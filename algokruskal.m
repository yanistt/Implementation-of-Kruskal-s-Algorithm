function [APM] = algokruskal(M)
%=================================================================%
%Entres : Matrice des poids de taille ||G|| * 3 , la colonne *1* aura 
%l'extrémité gauche de l'arete (sommetx), la colonne *2* aura l'extrémité 
%droite de l'arete (sommet y), la 3éme colonne sera utilisé pour inscrire le
%poids de l'arete
%Matrice adjacente de l'APM retourné
%=================================================================%
row = size(M,1); % nombre d'aretes, taille du graphe
maxim1=max(M(:,1)); %max de la colonne 1
maxim2=max(M(:,2)); %max de la colonne 2
maxim=max(maxim1,maxim2);% nombre de sommets du graphe
[lign sz] = size(M);
if 3 < 1 | 3 > sz | fix(3) ~= 3 % erreur car le tri n'est pas possible
   error;% erreur car le tri n'est pas possible
end
%=================================================================%
for it = 1 : lign - 1 %sinon on tri les arêtes de M par ordre croissant de valuation
    dol = lign + 1 - it;
    for it2 = 1 : dol - 1
        if M(it2,3) > M(it2 + 1,3)
            M([it2 it2 + 1],:) = M([it2 + 1 it2],:);%échange de ligne, swap (Permuter)
        end
    end
end
%=================================================================%
vec_int = zeros(1,maxim);
APM = zeros(maxim);
%=================================================================%
for it = 1 : row % vérification de si oui ou non il ya un cycle
    vect_res = M(it,[1 2]);
    gel=max(vec_int)+1;
    sz=0;
    maxim=length(vec_int);
% contrôle si nous insérons le sommet[i,j] dans le graphe. si cela créera
% de cylce ou noon
if vec_int(vect_res(1))==0 & vec_int(vect_res(2))==0
    vec_int(vect_res(1))=gel;
    vec_int(vect_res(2))=gel; % Variable de contôle
elseif vec_int(vect_res(1))==0
    vec_int(vect_res(1))=vec_int(vect_res(2));% Variable de contôle
elseif vec_int(vect_res(2))==0
    vec_int(vect_res(2))=vec_int(vect_res(1));% Variable de contôle
elseif vec_int(vect_res(1))==vec_int(vect_res(2))
    sz=1;    %ça s'arrête sinon
else
    mms=max(vec_int(vect_res(1)),vec_int(vect_res(2)));
    for it=1:maxim
        if vec_int(it)==mms
           vec_int(it)=min(vec_int(vect_res(1)),vec_int(vect_res(2)));%Le 
           %nouveau ensemble de sommets
       end
   end
end
    if sz == 1 % il ya bien un cycle !!
       M(it,:) = [0 0 0]; %nulité
   end
end
for it = 1 : row
    if M(it,[1 2]) ~= [0 0] %creation de la matrice d'adjacence
        APM(M(it,1),M(it,2)) = 1; %a partir des données insérés et ajoutés 
        %à la matrice M
        APM(M(it,2),M(it,1)) = 1;
    end
end