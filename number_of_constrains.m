function n = number_of_constrains(sys)
%NUMBER_OF_CONSTRAINS Get the number of system coordinates
n = length(sys.constraints.simple);
end

