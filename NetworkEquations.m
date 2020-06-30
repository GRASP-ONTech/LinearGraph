%% NetworkEquations

function [Model] = NetworkEquations(Model)
    %Create Tree Incidence Matrix
    A_tr = Model.In(2:end,logical(Model.Branches));
    %Create Co-Tree Incidence Matrix
    A_co = Model.In(2:end,logical(Model.Links));
    
    H = A_tr\A_co;
    
    %Create F-cutset matrix 
    %F_c = [H eye(size(H))];
    
    %Slip across- and through-variables for tree and co-tree
    ac_tr = Model.Across_Vars(logical(Model.Branches)); %across-variables of tree branches
    ac_co = Model.Across_Vars(logical(Model.Links));%across-variables of co-tree links
    th_tr = Model.Through_Vars(logical(Model.Branches)); %through-variables of tree branches
    th_co = Model.Through_Vars(logical(Model.Links)); %through-variables of tree links
    
    Model.cont_eqns = eye(length(th_tr))*th_tr == -H*th_co;
    Model.comp_eqns = eye(length(ac_co))*ac_co == H'*ac_tr;
end
