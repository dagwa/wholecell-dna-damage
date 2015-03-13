# WholeCell Summer School

The primary aim is to learn about standards for modelling and simulation in computational biology.  But a secondary aim is to enjoy modelling, coding and diagramming the whole-cell model using openly available software and COMBINE standards.

This module represents the *DNA Damage* the "whole-cell model" published in [Cell](http://www.ncbi.nlm.nih.gov/pubmed/22817898) by Karr *et al.*.

DNA_damage_presentations.pdf
===========================

Slides used for introductory and final presentations.

DNA_damage.xml
==============

SBML file generated using COPASI. Reactions consume/produce metabolites, but changes in the chromosome are not represented. (See also SBGN files in SBGN subdirectory.)

Namrata Tomar
Mahesh Sharma


DNA_repair.xml
==============

SBML file generated using COPASI.
Species including metabolites and enzymes, parameters, compartment and reactions are described as matlab code.
Kinetics are not clear and some parameters are missing for some reactions. (See also SBGN files in SBGN subdirectory.)

Audald Lloret-Villas
Vijayalakshmi Chelliah


extractReactions.m
==================
Matlab script for extracting information related to given processes from the kb (tableS3.xlsx), specifically all rows that are related to the reactions for the given processes.

