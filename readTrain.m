function [ T ] = readTrain( )
%READWHOLE Summary of this function goes here
%   Detailed explanation goes here
filename ='Training_Data.txt';
T=readtable(filename);
end

