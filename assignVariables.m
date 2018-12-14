%% Assigning variables
function [y] = assignVariables(index,no_of_training_egs,objects)

y = zeros(objects,no_of_training_egs);
y(index,:) = 1;

end
