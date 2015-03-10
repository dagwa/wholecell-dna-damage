function extractReactions(processes,kbfilename,outfilename)
%EXTRACTREACTIONS   Filter rows & sheets from knowledgebase table
%  extractReactions(processname) opens tableS3.xlsx, finds all reactions
%  belonging to the process from the Reactions sheet, then goes through all
%  sheets looking for a "Reaction" or "Process" column and discards all
%  rows which do not refer to any of the reactions or the given process.
%  The result is saved to a new xlsx file (without the original
%  formatting). 
%
%  The process name must match the entry in the reactions column exactly, 
% e.g. "Process_DNADamage".  To filter for multiple processes at once, give
% them as cell array, e.g.
% extractReactions({'Process_DNADamage','Process_DNARepair'}).
%
% As optional second argument, a different file name/path may be given
% (default is 'tableS3.xlsx' in the current directory).
% As optional third argument, a name for the output file may be given.

% Feb/Mar 2015, Arne Bittig for whole cell summer school



if nargin < 2 || isempty(kbfilename), kbfilename='tableS3.xlsx'; end


% read "reactions" sheet from table
[~,table,~]=xlsread(kbfilename,'S3O-Reactions');
% find index of row above actual content; i.e. last headline row, which
% contains "ID" in the first column; usually 4th, 5th or 6th
iHeadRow = find(strcmp(table(:,1),'ID'),1);
% find index of "Process" column
iProcCol=strcmp(table(iHeadRow,:),'Process');

%     if nargin == 0, % make 1 file for each process
%         for proc=unique(table(2:end,iProcCol))'
%             disp(['Extracting information for ' proc{1}]);
%             extractReactions(proc{1});
%         end
%     end

if ~iscell(processes), processes = {processes}; end

% extract reactions relevant to given processes
iReact=ismember(table(:,iProcCol),processes);
reactions=table(iReact,1); % work with reaction IDs, i.e. first column entries
    

if nargin < 3, outfilename=[processes{:} '-' kbfilename]; end


isreaction = @(x) any(ismember(regexp(x,';','split'),reactions));

[~,sheets]=xlsfinfo(kbfilename);

for sheetc=sheets
    sheet=sheetc{:}; % read a sheet...
    [~,table,raw]=xlsread(kbfilename,sheet);
    
    
    % find headline row
    iHeadRow = find(strcmp(table(:,1),'ID'),1);
    
    % find rows relevant to process' reactions
    iReactCol=find(strcmp(table(iHeadRow,:),'Reactions') ...
                        | strcmp(table(iHeadRow,:),'Reaction'));
    if ~isempty(iReactCol),
        iRelevant=cellfun(isreaction,table(:,iReactCol));
    else
        iRelevant=false(size(table,1),1);
    end
    
    % find rows relevant to process itself
    iProcCol=find(strcmp(table(iHeadRow,:),'Process'));
    if ~isempty(iProcCol),
        iRelevant=iRelevant | ismember(table(:,iProcCol),processes);
    end
    if ~any(iRelevant),
        disp(['Nothing relevant to reactions in ' sheet]);
    else
        iRelevant(1:iHeadRow)=true; % all headline rows are relevant
        xlswrite(outfilename,raw(iRelevant,:),sheet);
    end
end