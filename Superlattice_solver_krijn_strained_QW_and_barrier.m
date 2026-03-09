%Modelling superlattice devices using Krijns model and groundstate solver

fig = uifigure("Position",[50,50,1400,800]);
format long

% --- INTERFACE ELEMENTS --- %
Title = uilabel(fig,"Text",'Krijn Method - Krijn Constants', "Position",[50,750,600,30]);
%drop down menu for quantum well material
mat_QW = uidropdown(fig, ...
    "Position", [40, 40, 220, 40], ...
    "Items", ["AlP", "AlAs", "AlSb", "GaP", "GaAs", "GaSb", "InP", "InAs", "InSb", ...
              "Al As(x) Sb(1-x)", "Al(x) Ga(1-x) P", "Al(x) Ga(1-x) As", "Al(x) Ga(1-x) Sb", "Al(x) In(1-x) P", "Al(x) In(1-x) As", ...
              "Ga P(x) As(1-x)", "Ga As(x) Sb(1-x)", "Ga(x) In(1-x) P", "Ga(x) In(1-x) As", "Ga(x) In(1-x) Sb", ...
              "In P(x) As(1-x)", "In P(x) Sb(1-x)", "In As(x) Sb(1-x)", "Al(x) In(1-x) Sb", ...
              "Al(x) Ga(y) In(1-x-y) P", "Al(x) Ga(y) In(1-x-y) As", "In P(x) As(y) Sb(1-x-y)", "Al(x) Ga(y) In(1-x-y) Sb", ...
              "Al(x) Ga(1-x) As(y) Sb(1-y)", "Ga(x) In(1-x) P(y) As(1-y)", "Ga(x) In(1-x) As(y) Sb(1-y)", "In(x) Ga(1-x) As(y) Sb(1-y)"], ...
    "ItemsData", 1:32, ...
    "Value", 1);
lab_mat1 = uilabel(fig, "Text","QW material", "Position",[120, 70, 220, 40]);

%drop down menu for subtrate material
mat_sub = uidropdown(fig, ...
    "Position", [280, 40, 220, 40], ...
    "Items", ["AlP", "AlAs", "AlSb", "GaP", "GaAs", "GaSb", "InP", "InAs", "InSb", ...
              "Al As(x) Sb(1-x)", "Al(x) Ga(1-x) P", "Al(x) Ga(1-x) As", "Al(x) Ga(1-x) Sb", "Al(x) In(1-x) P", "Al(x) In(1-x) As", ...
              "Ga P(x) As(1-x)", "Ga As(x) Sb(1-x)", "Ga(x) In(1-x) P", "Ga(x) In(1-x) As", "Ga(x) In(1-x) Sb", ...
              "In P(x) As(1-x)", "In P(x) Sb(1-x)", "In As(x) Sb(1-x)", "Al(x) In(1-x) Sb", ...
              "Al(x) Ga(y) In(1-x-y) P", "Al(x) Ga(y) In(1-x-y) As", "In P(x) As(y) Sb(1-x-y)", "Al(x) Ga(y) In(1-x-y) Sb", ...
              "Al(x) Ga(1-x) As(y) Sb(1-y)", "Ga(x) In(1-x) P(y) As(1-y)", "Ga(x) In(1-x) As(y) Sb(1-y)", "In(x) Ga(1-x) As(y) Sb(1-y)"], ...
    "ItemsData", 1:32, ...
    "Value", 1);
lab_mat2 = uilabel(fig, "Text","Barrier", "Position",[360, 70, 220, 40]);

%generating axis and setting limits
ax = uiaxes(fig, "Position",[550, 40, 800, 800]);
ax.YLim = [-7,-6];

%slider for x_sub
text_x_sub = uitextarea(fig,"Position",[340,130,100,30]);
slid_x_sub = uislider(fig,"Orientation", "horizontal", "Position", [300,190,180,3],"Limits",[0,1],"Value",0);
lab_slid_x_sub = uilabel(fig, "Text","Slider for x barrier","Position",[340,190,120,40]);

%slider for y_sub
text_y_sub = uitextarea(fig,"Position",[340,240,100,30]);
slid_y_sub = uislider(fig,"Orientation", "horizontal", "Position", [300,300,180,3],"Limits",[0,1],"Value",0);
lab_slid_y_sub = uilabel(fig, "Text","Slider for y barrier","Position",[340,300,120,40]);

%slider for x_QW
text_x_QW = uitextarea(fig,"Position",[100,130,100,30]);
slid_x_QW = uislider(fig,"Orientation", "horizontal", "Position", [60,190,180,3],"Limits",[0,1],"Value",0);
lab_slid_x_QW = uilabel(fig, "Text","Slider for x QW material","Position",[90,190,140,40]);

%slider for y_sub
text_y_QW = uitextarea(fig,"Position",[100,240,100,30]);
slid_y_QW = uislider(fig,"Orientation", "horizontal", "Position", [60,300,180,3],"Limits",[0,1],"Value",0);
lab_slid_y_QW = uilabel(fig, "Text","Slider for y QW material","Position",[90,300,140,40]);

%adding a calculate buton
b = uibutton(fig, "Text","Calculate!","Position",[40,350,100,40]);

%adding a textbox with QW and sub properties
text_output = uitextarea(fig,"Position",[40,490,220,250]);


%adding inputs for length and particle mass
text_length_QW = uitextarea(fig, "Position",[140,410,100,30], "Value",'10');
lab_length_QW = uilabel(fig, "Text","Well Length (nm)","Position",[145,440,100,30]);

text_length_sub = uitextarea(fig, "Position",[250,410,100,30], "Value",'10');
lab_length_sub = uilabel(fig, "Text","Barrier Length (nm)","Position",[250,440,120,30]);

text_number_of = uitextarea(fig, "Position",[360,410,100,30], "Value",'10');
lab_number_of = uilabel(fig, "Text","Number of wells","Position",[365,440,100,30]);
%we are considering the number of wells here
%this means the number of barrier layers is n+1

% --- ASSIGNING CALLBACKS --- %
b.ButtonPushedFcn = @(src,event) (W_calc(mat_QW,mat_sub,text_length_QW,text_length_sub,text_x_QW,text_y_QW,text_x_sub,text_y_sub,text_number_of,ax,text_output));

slid_x_sub.ValueChangedFcn = @(src,event) (syncSliderToText(src, text_x_sub));
text_x_sub.ValueChangedFcn = @(src,event) (syncTextToSlider(src, slid_x_sub));

slid_y_sub.ValueChangedFcn = @(src,event) (syncSliderToText(src, text_y_sub));
text_y_sub.ValueChangedFcn = @(src,event) (syncTextToSlider(src, slid_y_sub));

slid_x_QW.ValueChangedFcn = @(src,event) (syncSliderToText(src, text_x_QW));
text_x_QW.ValueChangedFcn = @(src,event) (syncTextToSlider(src, slid_x_QW));

slid_y_QW.ValueChangedFcn = @(src,event) (syncSliderToText(src, text_y_QW));
text_y_QW.ValueChangedFcn = @(src,event) (syncTextToSlider(src, slid_y_QW));


% --- CALCULATING STRAINED BAND EDGES --- %
function band_positions = strain_solver(mat1, mat2, x_sub, y_sub, x_QW, y_QW)
    %material parameters, a, c11, c12, c44, Ev av, Delta0, Eg, av, ac, b
    mat_prop = [5.451, 1.32, 0.63, 0.62, -8.09, 0.000000506, 3.58, 3.15, -5.54, -12.9615;    %AlP       1
                5.660, 1.25, 0.53, 0.54, -7.49, 0.28, 2.95, 2.47, -5.64, -9.9238;            %AlAs      2
                6.136, 0.88, 0.43, 0.41, -6.66, 0.65, 2.22, 1.38, -6.97, -1.4;               %AlSb      3
                5.451, 1.41, 0.62, 0.7, -7.4, 0.08, 2.74, 1.7, -7.14, -1.5;                  %Gap       4
                5.653, 1.18, 0.54, 0.59, -6.92, 0.34, 1.42, 1.16, -7.17, -1.7;               %GaAs      5
                6.096, 0.88, 0.4, 0.43, -6.25, 0.82, 0.72, 0.79, -6.85, -2;                  %GaSb      6
                5.869, 1.02, 0.58, 0.46, -7.04, 0.11, 1.35, 1.27, -5.04, -1.6;               %InP       7   
                6.058, 0.83, 0.45, 0.4, -6.67, 0.38, 0.36, 1, -5.08, -1.8;                   %InAs      8
                6.479, 0.66, 0.36, 0.3, -6.09, 0.81, 0.17, 0.36, -6.17, -2.1];               %InSb      9

    %bowing parameters, need to calcalate bowing parameter of Ev av later
    bowing_parameters = [0.84, 0.15;    %Al As(x) Sb(1-x)       1
                        0, 0;          %Al(x) Ga(1-x) P         2
                        0.37, 0;       %Al(x) Ga(1-x) As        3
                        0.47, 0.3;     %Al(x) Ga(1-x) Sb        4
                        0, 0;          %Al(x) In(1-x) P         5
                        0.7, 0.15;     %Al(x) In(1-x) As        6
                        0.21, 0;       %Ga P(x) As(1-x)         7
                        1.2, 0;        %Ga As(x) Sb(1-x)        8
                        0.79, 0;       %Ga(x) In(1-x) P         9
                        0.38, 0.15;    %Ga(x) In(1-x) As        10
                        0.42, 0;       %Ga(x) In(1-x) Sb        11 
                        0.28, 0.1;     %In P(x) As(1-x)         12
                        1.3, 0.75;     %In P(x) Sb(1-x)         13
                        0.58, 1.2;     %In As(x) Sb(1-x)        14
                        0.43, 0.25];   %Al(x) In(1-x) Sb        15 (bowing parameters taken from Vurgauffmann)
    
    %lookup table holding all the tertiary alloys
    ter_alloys = [2, 3;      %Al As(x) Sb(1-x)      1
                  1, 4;      %Al(x) Ga(1-x) P       2
                  2, 5;      %Al(x) Ga(1-x) As      3
                  3, 6;      %Al(x) Ga(1-x) Sb      4
                  1, 7;      %Al(x) In(1-x) P       5
                  2, 8;      %Al(x) In(1-x) As      6
                  4, 5;      %Ga P(x) As(1-x)       7
                  5, 6;      %Ga As(x) Sb(1-x)      8
                  4, 7;      %Ga(x) In(1-x) P       9
                  5, 8;      %Ga(x) In(1-x) As      10 
                  6, 9;      %Ga(x) In(1-x) Sb      11
                  7, 8;      %In P(x) As(1-x)       12
                  7, 9;      %In P(x) Sb(1-x)       13
                  8, 9;      %In As(x) Sb(1-x)      14
                  3, 9];     %Al(x) In(1-x) Sb      15
    %look up table for quaternary case 1
    %(mat_1, mat_2, mat_3, bow_1, bow_2, bow_3)
    quat_c1_alloys = [1, 4, 7, 2, 5, 9;         %Al(x) Ga(y) In(1-x-y) P
                      2, 5, 8, 3, 6, 10;        %Al(x) Ga(y) In(1-x-y) As
                      7, 8, 9, 12, 13, 14;      %In P(x) As(y) Sb(1-x-y)
                      3, 6, 9, 4, 15, 11];     %Al(x) Ga(y) In(1-x-y) Sb
    %look up table for quaternary case 2 - T alloy 1 is the first alloy in
    %the quaternary, refering to position in ter_alloy table)
    %(T alloy 1, T alloy 2, T alloy 3 
    quat_c2_alloys = [3, 4, 1, 8;        %Al(x) Ga(1-x) As(y) Sb(1-y)
                      9, 10, 7, 12;      %Ga(x) In(1-x) P(y) As(1-y)
                      10, 11, 8, 14;     %Ga(x) In(1-x) As(y) Sb(1-y)
                      10, 11, 14, 8];    %In(x) Ga(1-x) As(y) Sb(1-y)
    
    %effective mass tables for electrons and holes
    % hh, c
    effective_mass = [0.52,0.22;                %AlP
                      0.44,0.13;                %AlAs
                      0.29,0.079;               %AlSb
                      0.41, 0.15;               %GaP
                      0.35, 0.07;               %GaAs
                      0.23, 0.064;              %GaSb
                      0.480,0.031;              %InP
                      0.39, 0.031;              %InAs
                      0.26, 0.03];              %InSb

    val1 = mat1;
    val2 = mat2;
    
    %case to handle normal substrate
    if val2<10 
        Ev_av_sub = mat_prop(val2, 5);
        Delta0_sub = mat_prop(val2, 6);
        Eg_sub = mat_prop(val2, 7); 
        a_sub = mat_prop(val2,1);
        elec_mass_sub = effective_mass(val2,2);
        hole_mass_sub = effective_mass(val2,1);
    end

    %case to handle tertiary alloy substrates
    if 9<val2 && val2<25     
        val2 = val2-9;
        sub_1 = ter_alloys(val2,1);
        sub_2 = ter_alloys(val2,2);

        Delta0_sub = (x_sub*mat_prop(sub_1, 6))+(1-x_sub)*(mat_prop(sub_2, 6))+(x_sub)*(x_sub-1)*(bowing_parameters(val2,2));
        Eg_sub = (x_sub*mat_prop(sub_1, 7))+(1-x_sub)*(mat_prop(sub_2, 7))+(x_sub)*(x_sub-1)*(bowing_parameters(val2,1));
        a_sub = (x_sub*mat_prop(sub_1, 1))+(1-x_sub)*(mat_prop(sub_2, 1));

        Cv_av_sub = 3*(mat_prop(sub_1, 8)-mat_prop(sub_2, 8))*(mat_prop(sub_1, 1)-mat_prop(sub_2, 1))/a_sub;
        Ev_av_sub = (x_sub*mat_prop(sub_1, 5))+(1-x_sub)*(mat_prop(sub_2, 5))+(x_sub)*(x_sub-1)*(Cv_av_sub);
        
        elec_mass_sub = (x_sub*effective_mass(sub_1, 2))+(1-x_sub)*(effective_mass(sub_2, 2));
        hole_mass_sub = (x_sub*effective_mass(sub_1, 1))+(1-x_sub)*(effective_mass(sub_2, 1));
    end
    
    %case to consider quaternary case 1 alloy substrates
    if 24<val2 && val2<29
        val2=val2-24;
        sub_1 = quat_c1_alloys(val2, 1);
        sub_2 = quat_c1_alloys(val2, 2);
        sub_3 = quat_c1_alloys(val2, 3);

        Delta0_sub = (x_sub*mat_prop(sub_1, 6))+(y_sub*(mat_prop(sub_2, 6)))+((1-x_sub-y_sub)*mat_prop(sub_3, 6))-((x_sub*(x_sub-1))*bowing_parameters(quat_c1_alloys(val2,4),2)) ...
        -((x_sub*(1-x_sub-y_sub))*bowing_parameters(quat_c1_alloys(val2,5),2))-((y_sub*(1-x_sub-y_sub))*bowing_parameters(quat_c1_alloys(val2,6),2));
                    
        Eg_sub = (x_sub*mat_prop(sub_1, 7))+(y_sub*(mat_prop(sub_2, 7)))+((1-x_sub-y_sub)*mat_prop(sub_3, 7))-((x_sub*(x_sub-1))*bowing_parameters(quat_c1_alloys(val2,4),1)) ...
        -((x_sub*(1-x_sub-y_sub))*bowing_parameters(quat_c1_alloys(val2,5),1))-((y_sub*(1-x_sub-y_sub))*bowing_parameters(quat_c1_alloys(val2,6),1));
        
        a_sub = (x_sub*mat_prop(sub_1, 1))+(y_sub*(mat_prop(sub_2, 1)))+((1-x_sub-y_sub)*mat_prop(sub_3, 1));

        Cv_av_sub_1 = 3*(mat_prop(sub_1, 8)-mat_prop(sub_2, 8))*(mat_prop(sub_1, 1)-mat_prop(sub_2, 1))/a_sub;
        Cv_av_sub_2 = 3*(mat_prop(sub_1, 8)-mat_prop(sub_3, 8))*(mat_prop(sub_1, 1)-mat_prop(sub_3, 1))/a_sub;
        Cv_av_sub_3 = 3*(mat_prop(sub_2, 8)-mat_prop(sub_3, 8))*(mat_prop(sub_2, 1)-mat_prop(sub_3, 1))/a_sub;
        Ev_av_sub = (x_sub*mat_prop(sub_1, 5))+(y_sub*(mat_prop(sub_2, 5)))+((1-x_sub-y_sub)*mat_prop(sub_3, 5))-((x_sub*(x_sub-1))*Cv_av_sub_1)-((x_sub*(1-x_sub-y_sub))*Cv_av_sub_2)-((y_sub*(1-x_sub-y_sub))*Cv_av_sub_3); 
        
        elec_mass_sub = (x_sub*effective_mass(sub_1, 2))+(y_sub*(effective_mass(sub_2, 2)))+((1-x_sub-y_sub)*effective_mass(sub_3, 2));    
        hole_mass_sub = (x_sub*effective_mass(sub_1, 1))+(y_sub*(effective_mass(sub_2, 1)))+((1-x_sub-y_sub)*effective_mass(sub_3, 1)); 
    end

    %case to consider quaternary case 2 alloy substrates
    if 28<val2 && val2<33 
        val2=val2-28;
        sub_T(1) = quat_c2_alloys(val2,1);
        sub_T(2) = quat_c2_alloys(val2,2);
        sub_T(3) = quat_c2_alloys(val2,3);
        sub_T(4) = quat_c2_alloys(val2,4);

        Delta0_sub = zeros(1,4);
        Eg_sub     = zeros(1,4);
        a_sub      = zeros(1,4);
        Cv_av_sub  = zeros(1,4);
        Ev_av_sub  = zeros(1,4);
        a_sub = [a_sub, a_sub, a_sub, a_sub];

        %calulating values for tertiary alloy 1-4
        
        for a = 1:2
            sub_1 = ter_alloys(sub_T(a), 1);
            sub_2 = ter_alloys(sub_T(a), 2);
        
            Delta0_sub(a) = (x_sub*mat_prop(sub_1, 6))+(1-x_sub)*(mat_prop(sub_2, 6))+(x_sub)*(x_sub-1)*(bowing_parameters(sub_T(a),2));
            Eg_sub(a) = (x_sub*mat_prop(sub_1, 7))+(1-x_sub)*(mat_prop(sub_2, 7))+(x_sub)*(x_sub-1)*(bowing_parameters(sub_T(a),1));
            a_sub(a) = (x_sub*mat_prop(sub_1, 1))+(1-x_sub)*(mat_prop(sub_2, 1));

            Cv_av_sub(a) = 3*(mat_prop(sub_1, 8)-mat_prop(sub_2, 8))*(mat_prop(sub_1, 1)-mat_prop(sub_2, 1)) ./ a_sub(a);
            Ev_av_sub(a) = (x_sub*mat_prop(sub_1, 5))+(1-x_sub)*(mat_prop(sub_2, 5))+(x_sub)*(x_sub-1)*(Cv_av_sub(a));
            elec_mass_sub(a) = (x_sub*effective_mass(sub_1, 2))+(1-x_sub)*(effective_mass(sub_2, 2));    
            hole_mass_sub(a) = (x_sub*effective_mass(sub_1, 1))+(1-x_sub)*(effective_mass(sub_2, 1)); 
        end

        for a = 3:4
            sub_1 = ter_alloys(sub_T(a), 1);
            sub_2 = ter_alloys(sub_T(a), 2);
        
            Delta0_sub(a) = (y_sub*mat_prop(sub_1, 6))+(1-y_sub)*(mat_prop(sub_2, 6))+(y_sub)*(y_sub-1)*(bowing_parameters(sub_T(a),2));
            Eg_sub(a) = (y_sub*mat_prop(sub_1, 7))+(1-y_sub)*(mat_prop(sub_2, 7))+(y_sub)*(y_sub-1)*(bowing_parameters(sub_T(a),1));
            a_sub(a) = (y_sub*mat_prop(sub_1, 1))+(1-y_sub)*(mat_prop(sub_2, 1));

            Cv_av_sub(a) = 3*(mat_prop(sub_1, 8)-mat_prop(sub_2, 8))*(mat_prop(sub_1, 1)-mat_prop(sub_2, 1))/a_sub(a);
            Ev_av_sub(a) = (y_sub*mat_prop(sub_1, 5))+(1-y_sub)*(mat_prop(sub_2, 5))+(y_sub)*(y_sub-1)*(Cv_av_sub(a));   
            elec_mass_sub(a) = (y_sub*effective_mass(sub_1, 2))+(1-y_sub)*(effective_mass(sub_2, 2));    
            hole_mass_QW(a) = (y_sub*effective_mass(sub_1, 1))+(1-y_sub)*(effective_mass(sub_2, 1));
        end

         %using tertiary values to calaculate final value
        Delta0_sub = (x_sub*(1-x_sub)*(y_sub*Delta0_sub(1)+(1-y_sub)*Delta0_sub(2))+(y_sub*(1-y_sub)*((x_sub*Delta0_sub(3))+(1-x_sub)*Delta0_sub(4))))/(x_sub*(1-x_sub)+y_sub*(1-y_sub));
        Eg_sub = (x_sub*(1-x_sub)*(y_sub*Eg_sub(1)+(1-y_sub)*Eg_sub(2))+(y_sub*(1-y_sub)*((x_sub*Eg_sub(3))+(1-x_sub)*Eg_sub(4))))/(x_sub*(1-x_sub)+y_sub*(1-y_sub));
        a_sub = (x_sub*(1-x_sub)*(y_sub*a_sub(1)+(1-y_sub)*a_sub(2))+(y_sub*(1-y_sub)*((x_sub*a_sub(3))+(1-x_sub)*a_sub(4))))/(x_sub*(1-x_sub)+y_sub*(1-y_sub));

        Ev_av_sub = (x_sub*(1-x_sub)*(y_sub*Ev_av_sub(1)+(1-y_sub)*Ev_av_sub(2))+(y_sub*(1-y_sub)*((x_sub*Ev_av_sub(3))+(1-x_sub)*Ev_av_sub(4))))/(x_sub*(1-x_sub)+y_sub*(1-y_sub));
        
        elec_mass_sub = (x_sub*(1-x_sub)*(y_sub*elec_mass_sub(1)+(1-y_sub)*elec_mass_sub(2))+(y_sub*(1-y_sub)*((x_sub*elec_mass_sub(3))+(1-x_sub)*elec_mass_sub(4))))/(x_sub*(1-x_sub)+y_sub*(1-y_sub));
        hole_mass_sub = (x_QW*(1-x_QW)*(y_sub*hole_mass_sub(1)+(1-y_sub)*hole_mass_sub(2))+(y_sub*(1-y_sub)*((x_sub*hole_mass_sub(3))+(1-x_sub)*hole_mass_sub(4))))/(x_sub*(1-x_sub)+y_sub*(1-y_sub));
    end

    %case to handle normal QW materials 
    if val1<10
        a_QW = mat_prop(val1,1);
        C11_QW = mat_prop(val1,2);
        C12_QW = mat_prop(val1,3);
        Ev_av_QW = mat_prop(val1,5);
        Delta0_QW = mat_prop(val1,6);
        Eg_QW = mat_prop(val1,7); 
        av_QW = mat_prop(val1,8); 
        ac_QW = mat_prop(val1,9);
        b_QW = mat_prop(val1,10);

        elec_mass_QW = effective_mass(val1,2);
        hole_mass_QW = effective_mass(val1,1);
    end

    %case to handle tertiary QW materials
    if 9<val1 && val1<25 
        val1 = val1-9;
        QW_1 = ter_alloys(val1,1);
        QW_2 = ter_alloys(val1,2);

        a_QW = (x_QW*mat_prop(QW_1, 1))+(1-x_QW)*(mat_prop(QW_2, 1));
        C11_QW = (x_QW*mat_prop(QW_1, 2))+(1-x_QW)*(mat_prop(QW_2, 2));
        C12_QW = (x_QW*mat_prop(QW_1, 3))+(1-x_QW)*(mat_prop(QW_2, 3));
        av_QW = (x_QW*mat_prop(QW_1, 8))+(1-x_QW)*(mat_prop(QW_2, 8)); 
        ac_QW = (x_QW*mat_prop(QW_1, 9))+(1-x_QW)*(mat_prop(QW_2, 9));
        b_QW = (x_QW*mat_prop(QW_1, 10))+(1-x_QW)*(mat_prop(QW_2, 10));

        Cv_av_QW = 3*(mat_prop(QW_1, 8)-mat_prop(QW_2, 8))*(mat_prop(QW_1, 1)-mat_prop(QW_2, 1))/a_sub;
        Ev_av_QW = (x_QW*mat_prop(QW_1, 5))+(1-x_QW)*(mat_prop(QW_2, 5))+(x_QW*(x_QW-1)*(Cv_av_QW));
        Delta0_QW = (x_QW*mat_prop(QW_1, 6))+(1-x_QW)*(mat_prop(QW_2, 6))+(x_QW)*(x_QW-1)*(bowing_parameters(val1,2));
        Eg_QW = (x_QW*mat_prop(QW_1, 7))+(1-x_QW)*(mat_prop(QW_2, 7))+(x_QW)*(x_QW-1)*(bowing_parameters(val1,1));

        elec_mass_QW = (x_QW*effective_mass(QW_1, 2))+(1-x_QW)*(effective_mass(QW_2, 2));
        hole_mass_QW = (x_QW*effective_mass(QW_1, 1))+(1-x_QW)*(effective_mass(QW_2, 1));
    end

    %case to handle type 1 quaternary QW materials 
    if 24<val1 && val1<29
        val1=val1-24;
        QW_1 = quat_c1_alloys(val1, 1);
        QW_2 = quat_c1_alloys(val1, 2);
        QW_3 = quat_c1_alloys(val1, 3);
        
        a_QW = (x_QW*mat_prop(QW_1, 1))+(y_QW*(mat_prop(QW_2, 1)))+((1-x_QW-y_QW)*mat_prop(QW_3, 1));
        C11_QW = (x_QW*mat_prop(QW_1, 2))+(y_QW*(mat_prop(QW_2, 2)))+((1-x_QW-y_QW)*mat_prop(QW_3, 2));
        C12_QW = (x_QW*mat_prop(QW_1, 3))+(y_QW*(mat_prop(QW_2, 3)))+((1-x_QW-y_QW)*mat_prop(QW_3, 3));
        av_QW = (x_QW*mat_prop(QW_1, 8))+(y_QW*(mat_prop(QW_2, 8)))+((1-x_QW-y_QW)*mat_prop(QW_3, 8)); 
        ac_QW = (x_QW*mat_prop(QW_1, 9))+(y_QW*(mat_prop(QW_2, 9)))+((1-x_QW-y_QW)*mat_prop(QW_3, 9));
        b_QW = (x_QW*mat_prop(QW_1, 10))+(y_QW*(mat_prop(QW_2, 10)))+((1-x_QW-y_QW)*mat_prop(QW_3, 10));    

        Delta0_QW = (x_QW*mat_prop(QW_1, 6))+(y_QW*(mat_prop(QW_2, 6)))+((1-x_QW-y_QW)*mat_prop(QW_3, 6))-((x_QW*(x_QW-1))*bowing_parameters(quat_c1_alloys(val1,4),2)) ...
        -((x_QW*(1-x_QW-y_QW))*bowing_parameters(quat_c1_alloys(val1,5),2))-((y_QW*(1-x_QW-y_QW))*bowing_parameters(quat_c1_alloys(val1,6),2));
                    
        Eg_QW = (x_QW*mat_prop(QW_1, 7))+(y_QW*(mat_prop(QW_2, 7)))+((1-x_QW-y_QW)*mat_prop(QW_3, 7))-((x_QW*(x_QW-1))*bowing_parameters(quat_c1_alloys(val1,4),1)) ...
        -((x_QW*(1-x_QW-y_QW))*bowing_parameters(quat_c1_alloys(val1,5),1))-((y_QW*(1-x_QW-y_QW))*bowing_parameters(quat_c1_alloys(val1,6),1));
        

        Cv_av_QW_1 = 3*(mat_prop(QW_1, 8)-mat_prop(QW_2, 8))*(mat_prop(QW_1, 1)-mat_prop(QW_2, 1))/a_sub;
        Cv_av_QW_2 = 3*(mat_prop(QW_1, 8)-mat_prop(QW_3, 8))*(mat_prop(QW_1, 1)-mat_prop(QW_3, 1))/a_sub;
        Cv_av_QW_3 = 3*(mat_prop(QW_2, 8)-mat_prop(QW_3, 8))*(mat_prop(QW_2, 1)-mat_prop(QW_3, 1))/a_sub;
        Ev_av_QW = (x_QW*mat_prop(QW_1, 5))+(y_QW*(mat_prop(QW_2, 5)))+((1-x_QW-y_QW)*mat_prop(QW_3, 5))-((x_QW*(x_QW-1))*Cv_av_QW_1)-((x_QW*(1-x_QW-y_QW))*Cv_av_QW_2)-((y_QW*(1-x_QW-y_QW))*Cv_av_QW_3); 
        
        elec_mass_QW = (x_QW*effective_mass(QW_1, 2))+(y_QW*(effective_mass(QW_2, 2)))+((1-x_QW-y_QW)*effective_mass(QW_3, 2));    
        hole_mass_QW = (x_QW*effective_mass(QW_1, 1))+(y_QW*(effective_mass(QW_2, 1)))+((1-x_QW-y_QW)*effective_mass(QW_3, 1)); 
    end

    %case to handle type 2 quaternary QW materials
    if 28<val1 && val1<33 
        val1=val1-28;
        QW_T(1) = quat_c2_alloys(val1,1);
        QW_T(2) = quat_c2_alloys(val1,2);
        QW_T(3) = quat_c2_alloys(val1,3);
        QW_T(4) = quat_c2_alloys(val1,4);

        Delta0_QW = zeros(1,4);
        Eg_QW     = zeros(1,4);
        a_QW      = zeros(1,4);
        Cv_av_QW  = zeros(1,4);
        Ev_av_QW  = zeros(1,4);
        a_sub_QW = [a_sub, a_sub, a_sub, a_sub];
        
        %calulating values for tertiary alloy 1-4
        
        for a = 1:2
            QW_1 = ter_alloys(QW_T(a), 1);
            QW_2 = ter_alloys(QW_T(a), 2);
        
            Delta0_QW(a) = (x_QW*mat_prop(QW_1, 6))+(1-x_QW)*(mat_prop(QW_2, 6))+(x_QW)*(x_QW-1)*(bowing_parameters(QW_T(a),2));
            Eg_QW(a) = (x_QW*mat_prop(QW_1, 7))+(1-x_QW)*(mat_prop(QW_2, 7))+(x_QW)*(x_QW-1)*(bowing_parameters(QW_T(a),1));
            
            Cv_av_QW(a) = 3*(mat_prop(QW_1, 8)-mat_prop(QW_2, 8))*(mat_prop(QW_1, 1)-mat_prop(QW_2, 1)) ./ a_sub_QW(a);
            Ev_av_QW(a) = (x_QW*mat_prop(QW_1, 5))+(1-x_QW)*(mat_prop(QW_2, 5))+(x_QW)*(x_QW-1)*(Cv_av_QW(a));
     
            a_QW(a) = (x_QW*mat_prop(QW_1, 1))+(1-x_QW)*(mat_prop(QW_2, 1));
            C11_QW(a) = (x_QW*mat_prop(QW_1, 2))+(1-x_QW)*(mat_prop(QW_2, 2));
            C12_QW(a) = (x_QW*mat_prop(QW_1, 3))+(1-x_QW)*(mat_prop(QW_2, 3));
            av_QW(a) = (x_QW*mat_prop(QW_1, 8))+(1-x_QW)*(mat_prop(QW_2, 8)); 
            ac_QW(a) = (x_QW*mat_prop(QW_1, 9))+(1-x_QW)*(mat_prop(QW_2, 9));
            b_QW(a) = (x_QW*mat_prop(QW_1, 10))+(1-x_QW)*(mat_prop(QW_2, 10));

            elec_mass_QW(a) = (x_QW*effective_mass(QW_1, 2))+(1-x_QW)*(effective_mass(QW_2, 2));    
            hole_mass_QW(a) = (x_QW*effective_mass(QW_1, 1))+(1-x_QW)*(effective_mass(QW_2, 1)); 
        end

        for a = 3:4
            QW_1 = ter_alloys(QW_T(a), 1);
            QW_2 = ter_alloys(QW_T(a), 2);
        
            Delta0_QW(a) = (y_QW*mat_prop(QW_1, 6))+(1-y_QW)*(mat_prop(QW_2, 6))+(y_QW)*(y_QW-1)*(bowing_parameters(QW_T(a),2));
            Eg_QW(a) = (y_QW*mat_prop(QW_1, 7))+(1-y_QW)*(mat_prop(QW_2, 7))+(y_QW)*(y_QW-1)*(bowing_parameters(QW_T(a),1));
           
            Cv_av_QW(a) = 3*(mat_prop(QW_1, 8)-mat_prop(QW_2, 8))*(mat_prop(QW_1, 1)-mat_prop(QW_2, 1))/a_sub_QW(a);
            Ev_av_QW(a) = (y_QW*mat_prop(QW_1, 5))+(1-y_QW)*(mat_prop(QW_2, 5))+(y_QW)*(y_QW-1)*(Cv_av_QW(a));   

            a_QW(a) = (y_QW*mat_prop(QW_1, 1))+(1-y_QW)*(mat_prop(QW_2, 1));
            C11_QW(a) = (y_QW*mat_prop(QW_1, 2))+(1-y_QW)*(mat_prop(QW_2, 2));
            C12_QW(a) = (y_QW*mat_prop(QW_1, 3))+(1-y_QW)*(mat_prop(QW_2, 3));
            av_QW(a) = (y_QW*mat_prop(QW_1, 8))+(1-y_QW)*(mat_prop(QW_2, 8)); 
            ac_QW(a) = (y_QW*mat_prop(QW_1, 9))+(1-y_QW)*(mat_prop(QW_2, 9));
            b_QW(a) = (y_QW*mat_prop(QW_1, 10))+(1-y_QW)*(mat_prop(QW_2, 10));

            elec_mass_QW(a) = (y_QW*effective_mass(QW_1, 2))+(1-y_QW)*(effective_mass(QW_2, 2));    
            hole_mass_QW(a) = (y_QW*effective_mass(QW_1, 1))+(1-y_QW)*(effective_mass(QW_2, 1));
        end

         %using tertiary values to calaculate final value
        Delta0_QW = (x_QW*(1-x_QW)*(y_QW*Delta0_QW(1)+(1-y_QW)*Delta0_QW(2))+(y_QW*(1-y_QW)*((x_QW*Delta0_QW(3))+(1-x_QW)*Delta0_QW(4))))/(x_QW*(1-x_QW)+y_QW*(1-y_QW));
        Eg_QW = (x_QW*(1-x_QW)*(y_QW*Eg_QW(1)+(1-y_QW)*Eg_QW(2))+(y_QW*(1-y_QW)*((x_QW*Eg_QW(3))+(1-x_QW)*Eg_QW(4))))/(x_QW*(1-x_QW)+y_QW*(1-y_QW));
        
        a_QW = (x_QW*(1-x_QW)*((y_QW*a_QW(1))+((1-y_QW)*a_QW(2)))+(y_QW*(1-y_QW)*((x_QW*a_QW(3))+((1-x_QW)*a_QW(4)))))/(x_QW*(1-x_QW)+y_QW*(1-y_QW));
        C11_QW = (x_QW*(1-x_QW)*(y_QW*C11_QW(1)+(1-y_QW)*C11_QW(2))+(y_QW*(1-y_QW)*((x_QW*C11_QW(3))+(1-x_QW)*C11_QW(4))))/(x_QW*(1-x_QW)+y_QW*(1-y_QW));
        C12_QW = (x_QW*(1-x_QW)*(y_QW*C12_QW(1)+(1-y_QW)*C12_QW(2))+(y_QW*(1-y_QW)*((x_QW*C12_QW(3))+(1-x_QW)*C12_QW(4))))/(x_QW*(1-x_QW)+y_QW*(1-y_QW));
        av_QW = (x_QW*(1-x_QW)*(y_QW*av_QW(1)+(1-y_QW)*av_QW(2))+(y_QW*(1-y_QW)*((x_QW*av_QW(3))+(1-x_QW)*av_QW(4))))/(x_QW*(1-x_QW)+y_QW*(1-y_QW));   
        ac_QW = (x_QW*(1-x_QW)*(y_QW*ac_QW(1)+(1-y_QW)*ac_QW(2))+(y_QW*(1-y_QW)*((x_QW*ac_QW(3))+(1-x_QW)*ac_QW(4))))/(x_QW*(1-x_QW)+y_QW*(1-y_QW));
        b_QW = (x_QW*(1-x_QW)*(y_QW*b_QW(1)+(1-y_QW)*b_QW(2))+(y_QW*(1-y_QW)*((x_QW*b_QW(3))+(1-x_QW)*b_QW(4))))/(x_QW*(1-x_QW)+y_QW*(1-y_QW));

        Ev_av_QW = (x_QW*(1-x_QW)*(y_QW*Ev_av_QW(1)+(1-y_QW)*Ev_av_QW(2))+(y_QW*(1-y_QW)*((x_QW*Ev_av_QW(3))+(1-x_QW)*Ev_av_QW(4))))/(x_QW*(1-x_QW)+y_QW*(1-y_QW));

        elec_mass_QW = (x_QW*(1-x_QW)*(y_QW*elec_mass_QW(1)+(1-y_QW)*elec_mass_QW(2))+(y_QW*(1-y_QW)*((x_QW*elec_mass_QW(3))+(1-x_QW)*elec_mass_QW(4))))/(x_QW*(1-x_QW)+y_QW*(1-y_QW));
        hole_mass_QW = (x_QW*(1-x_QW)*(y_QW*hole_mass_QW(1)+(1-y_QW)*hole_mass_QW(2))+(y_QW*(1-y_QW)*((x_QW*hole_mass_QW(3))+(1-x_QW)*hole_mass_QW(4))))/(x_QW*(1-x_QW)+y_QW*(1-y_QW));
    end
    
    %final calculations for band edges, and returning result
    Ev_sub = Ev_av_sub + (Delta0_sub / 3);
    Ec_sub = Ev_av_sub + (Delta0_sub / 3) + Eg_sub;

    a_para = a_sub;
    D = 2*(C12_QW / C11_QW);
    a_perp = a_QW*(1-D*((a_para / a_QW)-1));
    epsi_para = ((a_para / a_QW)-1);
    epsi_perp = ((a_perp / a_QW)-1);
    DeltaE_hy_v_av = av_QW*((2*epsi_para)+epsi_perp); 
    DeltaE_hy_c = ac_QW*((2*epsi_para)+epsi_perp);
    deltaE_sh = 2*b_QW*(epsi_perp-epsi_para);

    DeltaE_sh_hh = -0.5*deltaE_sh;
    DeltaE_sh_lh = (-0.5)*(Delta0_QW) + 0.25*deltaE_sh + 0.5*((Delta0_QW^2)+(Delta0_QW*deltaE_sh)+((9/4)*(deltaE_sh.^2))).^0.5;

    Ev_QW = Ev_av_QW + (Delta0_QW / 3) + DeltaE_hy_v_av + max(DeltaE_sh_hh, DeltaE_sh_lh);
    Ec_QW = Ev_av_QW + (Delta0_QW / 3) + Eg_QW + DeltaE_hy_c;

    band_positions = [Ev_sub, Ec_sub, Ev_QW, Ec_QW, hole_mass_QW, elec_mass_QW, hole_mass_sub, elec_mass_sub];
end
% --- CALCULATING GROUND STATES --- %
function ground_states = ground_state_solver(hole_mass,length,hole_U)
    hbar = 1.054571817e-34;
    hole_mass =  hole_mass*9.1093837139*10^-31;  
    length = length*10^-9;                      
    hole_U = (hole_U)*1.602176634*10^-19;
    
    %initial estimates
    hole_E = (pi^2 * hbar^2) / (2 * hole_mass * length^2);
    hole_alpha = sqrt((2*hole_mass*(hole_U - hole_E)) / hbar^2);
    hole_Leff = length + 2/hole_alpha;
    
    %max number of iterations
    n = 2000;
    tolerance = 1e-10; 
    
    %iteration loop
    for i = 1:n
        hole_E_next = (pi^2 * hbar^2) / (2 * hole_mass * hole_Leff^2);
   
        hole_alpha_next = sqrt((2*hole_mass*(hole_U - hole_E_next)) / hbar^2);
        hole_new_Leff = length + 2/hole_alpha_next;
    
        if abs(hole_new_Leff - hole_Leff) < tolerance
            break
        end

        hole_Leff = hole_new_Leff;
    end
    hole_E_next = real(hole_E_next);
    ground_states = (hole_E_next/(1.602176634*10^-19));
    disp(ground_states)
end

% --- CALCULATING EMISSION WAVELENGTH --- %
function W_calc(mat_QW,mat_sub,text_length_QW,text_length_sub,text_x_QW,text_y_QW,text_x_sub,text_y_sub,text_number_of,ax,text_output)
%importing values
mat_QW = mat_QW.Value;
mat_sub = mat_sub.Value;

x_QW = str2double(text_x_QW.Value);
y_QW = str2double(text_y_QW.Value);
x_sub = str2double(text_x_sub.Value);
y_sub = str2double(text_y_sub.Value);

length_QW = str2double(text_length_QW.Value);
length_sub = str2double(text_length_sub.Value);
number_of_wells = str2double(text_number_of.Value);

%calculating effect of strain
QW_strained = strain_solver(mat_QW, mat_sub, x_sub, y_sub, x_QW, y_QW);
sub_strained = strain_solver(mat_sub, mat_QW, x_QW, y_QW, x_sub, y_sub);

%calculating electron and hole effective masses 
x_average = (length_QW*number_of_wells)/(((number_of_wells+1)*length_sub)+(number_of_wells)*length_QW);
averaged_elec_mass = x_average*QW_strained(6) + (1-x_average)*QW_strained(8);
averaged_hole_mass = x_average*QW_strained(5) + (1-x_average)*QW_strained(7);
total_superlattice_length = (number_of_wells*length_QW)+((number_of_wells+1)*length_sub);

elec_U = -1*(-1*sub_strained(4)+QW_strained(4));
hole_U = -1*(-1*sub_strained(3)+QW_strained(3));

superlattice_elec_groundstate = ground_state_solver(averaged_elec_mass,total_superlattice_length,elec_U);
superlattice_hole_groundstate = ground_state_solver(averaged_hole_mass,total_superlattice_length,hole_U);

band_gap=(-1*QW_strained(3)+sub_strained(4)+superlattice_hole_groundstate+superlattice_elec_groundstate);

%printing output
text_output.Value = {'% --- --- --- %', ...
                     ['QW valence - ', num2str(QW_strained(3)), ' eV'], ...
                     ['QW conduction - ', num2str(QW_strained(4)), ' eV'], ...
                     ['Barrier valence - ', num2str(sub_strained(3)), ' eV'], ...
                     ['Barrier conduction - ', num2str(sub_strained(4)), ' eV'], ...
                     '% --- --- --- %', ...
                     ['QW effective electron groundstate - ', num2str(superlattice_elec_groundstate), ' eV'], ...
                     ['QW effective hole groundstate - ', num2str(superlattice_hole_groundstate), ' eV'], ...
                     ['Elec U - ', num2str(elec_U), ' eV'], ...
                     ['Hole U - ', num2str(hole_U), ' eV'], ...
                     '% --- --- --- %', ...
                     ['Groundstate to groundstate - ', num2str(band_gap), ' eV'], ...
                     '% --- --- --- %', ...
                     ['Wavelength - ', num2str(1239.84193/band_gap), 'nm']};

%plotting everything on the graph
QW_v = sym(QW_strained(3));
QW_c = sym(QW_strained(4));
sub_v = sym(sub_strained(3));
sub_c = sym(sub_strained(4));
elec_ground = sym(superlattice_elec_groundstate);
hole_ground = sym(superlattice_hole_groundstate);
syms x;


y_Ev = piecewise((0 <= x & x < length_sub*2), sub_v, ...
                 (length_sub*2 <= x & x < length_sub*2+length_QW), QW_v, ...
                 (length_sub*2+length_QW <= x & x < length_sub*3+length_QW), sub_v, ...
                 (length_sub*3+length_QW <= x & x < length_sub*3+length_QW*2), QW_v, ...
                 (length_sub*3+length_QW*2 <= x & x <= length_sub*5+length_QW*2), sub_v);

y_Ec = piecewise((0 <= x & x < length_sub*2), sub_c, ...
                 (length_sub*2 <= x & x < length_sub*2+length_QW), QW_c, ...
                 (length_sub*2+length_QW <= x & x < length_sub*3+length_QW), sub_c, ...
                 (length_sub*3+length_QW <= x & x < length_sub*3+length_QW*2), QW_c, ...
                 (length_sub*3+length_QW*2 <= x & x <= length_sub*5+length_QW*2), sub_c);

cla(ax)
hold(ax, 'on')
     fplot(ax, y_Ev, [0 length_sub*5+length_QW*2])
     fplot(ax, y_Ec, [0 length_sub*5+length_QW*2])
     fplot(ax, QW_v+elec_ground, [0 length_sub*5+length_QW*2])
     fplot(ax, QW_c+hole_ground, [0 length_sub*5+length_QW*2])
hold(ax, 'off')
end

function syncSliderToText(slider, textBox)
    textBox.Value = { num2str(slider.Value) };
end
function syncTextToSlider(textBox, slider)
    val = str2double(textBox.Value);
    if ~isnan(val)
        slider.Value = val;
    end
end