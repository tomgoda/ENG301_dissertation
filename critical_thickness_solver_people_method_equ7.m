%Modelling Semiconducor Bandgaps Using Krijins Mathmatical Method
%paper used - Calculation of critical layer thickness versus lattice mismatch for GexSi1−x/Si strained‐layer heterostructures
%https://pubs.aip.org/aip/apl/article/47/3/322/1023078/Calculation-of-critical-layer-thickness-versus

fig = uifigure("Position",[50,50,540,700]);
format long

% --- INTERFACE ELEMENTS --- %
Title = uilabel(fig,"Text",'Critical Layer Thickness Solver - Krijn Constants', "Position",[50,650,400,30]);
%drop down menu for mat1
mat1 = uidropdown(fig, ...
    "Position", [40, 40, 220, 40], ...
    "Items", ["AlP", "AlAs", "AlSb", "GaP", "GaAs", "GaSb", "InP", "InAs", "InSb", ...
              "Al As(x) Sb(1-x)", "Al(x) Ga(1-x) P", "Al(x) Ga(1-x) As", "Al(x) Ga(1-x) Sb", "Al(x) In(1-x) P", "Al(x) In(1-x) As", ...
              "Ga P(x) As(1-x)", "Ga As(x) Sb(1-x)", "Ga(x) In(1-x) P", "Ga(x) In(1-x) As", "Ga(x) In(1-x) Sb", ...
              "In P(x) As(1-x)", "In P(x) Sb(1-x)", "In As(x) Sb(1-x)", ...
              "Al(x) Ga(y) In(1-x-y) P", "Al(x) Ga(y) In(1-x-y) As", "In P(x) As(y) Sb(1-x-y)", ...
              "Al(x) Ga(1-x) As(y) Sb(1-y)", "Ga(x) In(1-x) P(y) As(1-y)", "Ga(x) In(1-x) As(y) Sb(1-y)"], ...
    "ItemsData", 1:29, ...
    "Value", 1);
lab_mat1 = uilabel(fig, "Text","Layer material", "Position",[120, 70, 220, 40]);

%drop down menu for mat2
mat2 = uidropdown(fig, ...
    "Position", [280, 40, 220, 40], ...
    "Items", ["AlP", "AlAs", "AlSb", "GaP", "GaAs", "GaSb", "InP", "InAs", "InSb", ...
              "Al As(x) Sb(1-x)", "Al(x) Ga(1-x) P", "Al(x) Ga(1-x) As", "Al(x) Ga(1-x) Sb", "Al(x) In(1-x) P", "Al(x) In(1-x) As", ...
              "Ga P(x) As(1-x)", "Ga As(x) Sb(1-x)", "Ga(x) In(1-x) P", "Ga(x) In(1-x) As", "Ga(x) In(1-x) Sb", ...
              "In P(x) As(1-x)", "In P(x) Sb(1-x)", "In As(x) Sb(1-x)", ...
              "Al(x) Ga(y) In(1-x-y) P", "Al(x) Ga(y) In(1-x-y) As", "In P(x) As(y) Sb(1-x-y)", ...
              "Al(x) Ga(1-x) As(y) Sb(1-y)", "Ga(x) In(1-x) P(y) As(1-y)", "Ga(x) In(1-x) As(y) Sb(1-y)"], ...
    "ItemsData", 1:29, ...
    "Value", 1);
lab_mat2 = uilabel(fig, "Text","Subtrate", "Position",[360, 70, 220, 40]);

%slider for x_sub
text_x_sub = uitextarea(fig,"Position",[340,130,100,30]);
slid_x_sub = uislider(fig,"Orientation", "horizontal", "Position", [300,190,180,3],"Limits",[0,1],"Value",0);
lab_slid_x_sub = uilabel(fig, "Text","Slider for x substrate","Position",[340,190,120,40]);

%slider for y_sub
text_y_sub = uitextarea(fig,"Position",[340,240,100,30]);
slid_y_sub = uislider(fig,"Orientation", "horizontal", "Position", [300,300,180,3],"Limits",[0,1],"Value",0);
lab_slid_y_sub = uilabel(fig, "Text","Slider for y substrate","Position",[340,300,120,40]);

%slider for x_QW
text_x_layer = uitextarea(fig,"Position",[100,130,100,30]);
slid_x_layer = uislider(fig,"Orientation", "horizontal", "Position", [60,190,180,3],"Limits",[0,1],"Value",0);
lab_slid_x_layer = uilabel(fig, "Text","Slider for x layer material","Position",[90,190,140,40]);

%slider for y_sub
text_y_layer = uitextarea(fig,"Position",[100,240,100,30]);
slid_y_layer = uislider(fig,"Orientation", "horizontal", "Position", [60,300,180,3],"Limits",[0,1],"Value",0);
lab_slid_y_layer = uilabel(fig, "Text","Slider for y layer  material","Position",[90,300,140,40]);

%adding a calculate buton
b = uibutton(fig, "Text","Calculate!","Position",[40,350,100,40]);

%adding a textbox with QW and sub properties
left_box = uitextarea(fig,"Position",[40,440,220,200]);
right_box = uitextarea(fig,"Position",[280,440,220,200]);

initial_hc = uitextarea(fig,"Position",[400,350,100,30]);
lab_initial_hc = uilabel(fig, "Text","Initial hc","Position",[420,370,140,40]);

% --- ASSIGNING CALLBACKS --- %
b.ButtonPushedFcn = @(src,event) update_calc(mat1, mat2, slid_x_sub, slid_y_sub, slid_x_layer, slid_y_layer, right_box, left_box, initial_hc);

slid_x_sub.ValueChangedFcn = @(src,event) (syncSliderToText(src, text_x_sub));
text_x_sub.ValueChangedFcn = @(src,event) (syncTextToSlider(src, slid_x_sub));

slid_y_sub.ValueChangedFcn = @(src,event) (syncSliderToText(src, text_y_sub));
text_y_sub.ValueChangedFcn = @(src,event) (syncTextToSlider(src, slid_y_sub));

slid_x_layer.ValueChangedFcn = @(src,event) (syncSliderToText(src, text_x_layer));
text_x_layer.ValueChangedFcn = @(src,event) (syncTextToSlider(src, slid_x_layer));

slid_y_layer.ValueChangedFcn = @(src,event) (syncSliderToText(src, text_y_layer));
text_y_layer.ValueChangedFcn = @(src,event) (syncTextToSlider(src, slid_y_layer));


% --- CALCULATE CALLBACK FUNCTION --- %
function update_calc(mat1, mat2, slid_x_sub, slid_y_sub, slid_x_layer, slid_y_layer, left_box, right_box, initial_hc)
    %material parameters, a, c11, c12, b
    mat_prop = [5.451, 1.32, 0.63;    %AlP
                5.660, 1.25, 0.53;     %AlAs
                6.136, 0.88, 0.43;        %AlSb
                5.451, 1.41, 0.62;        %Gap
                5.653, 1.18, 0.54;        %GaAs
                6.096, 0.88, 0.4;           %GaSb
                5.869, 1.02, 0.58;        %InP
                6.058, 0.83, 0.45;        %InAs
                6.479, 0.66, 0.36];       %InSb
    
    %lookup table holding all the tertiary alloys
    ter_alloys = [2, 3;      %Al As(x) Sb(1-x)
                  1, 4;      %Al(x) Ga(1-x) P
                  2, 5;      %Al(x) Ga(1-x) As
                  3, 6;      %Al(x) Ga(1-x) Sb
                  1, 7;      %Al(x) In(1-x) P
                  2, 8;      %Al(x) In(1-x) As
                  4, 5;      %Ga P(x) As(1-x)
                  5, 6;      %Ga As(x) Sb(1-x)
                  4, 7;      %Ga(x) In(1-x) P
                  5, 8;      %Ga(x) In(1-x) As
                  6, 9;      %Ga(x) In(1-x) Sb  
                  7, 8;      %In P(x) As(1-x)
                  7, 9;      %In P(x) Sb(1-x)
                  8, 9];     %In As(x) Sb(1-x)
    
    %look up table for quaternary case 1
    %(mat_1, mat_2, mat_3, bow_1, bow_2, bow_3)
    quat_c1_alloys = [1, 4, 7;
                      2, 5, 8;
                      7, 8, 9];

    %look up table for quaternary case 2 - T alloy 1 is the first alloy in
    %the quaternary, refering to position in ter_alloy table)
    %(T alloy 1, T alloy 2, T alloy 3 
    quat_c2_alloys = [3, 4, 1, 8;        %Al(x) Ga(1-x) As(y) Sb(1-y)
                      9, 10, 7, 12;      %Ga(x) In(1-x) P(y) As(1-y)
                      10, 11, 8, 14];    %Ga(x) In(1-x) As(y) Sb(1-y)

    val1 = mat1.Value;   % correct variable names
    val2 = mat2.Value;   % correct variable names
    
    %case to handle normal substrate
    if val2<10  
        a_sub = mat_prop(val2,1);
    end

    %case to handle tertiary alloy substrates
    if 9<val2 && val2<24     
        val2 = val2-9;
        sub_1 = ter_alloys(val2,1);
        sub_2 = ter_alloys(val2,2);
        x_sub = slid_x_sub.Value;
        a_sub = (x_sub*mat_prop(sub_1, 1))+(1-x_sub)*(mat_prop(sub_2, 1));
    end
    
    %case to consider quaternary case 1 alloy substrates
    if 23<val2 && val2<27
        val2=val2-23;
        sub_1 = quat_c1_alloys(val2, 1);
        sub_2 = quat_c1_alloys(val2, 2);
        sub_3 = quat_c1_alloys(val2, 3);

        x_sub = slid_x_sub.Value;
        y_sub = slid_y_sub.Value;

        a_sub = (x_sub*mat_prop(sub_1, 1))+(y_sub*(mat_prop(sub_2, 1)))+((1-x_sub-y_sub)*mat_prop(sub_3, 1));
    end

    %case to consider quaternary case 2 alloy substrates
    if 26<val2 && val2<30 
        val2=val2-26;
        sub_T(1) = quat_c2_alloys(val2,1);
        sub_T(2) = quat_c2_alloys(val2,2);
        sub_T(3) = quat_c2_alloys(val2,3);
        sub_T(4) = quat_c2_alloys(val2,4);

        x_sub = slid_x_sub.Value;
        y_sub = slid_y_sub.Value;
        
        %calulating values for tertiary alloy 1-4
        
        for a = 1:2
            sub_1 = ter_alloys(sub_T(a), 1);
            sub_2 = ter_alloys(sub_T(a), 2);
        
            a_sub(a) = (x_sub*mat_prop(sub_1, 1))+(1-x_sub)*(mat_prop(sub_2, 1));
        end

        for a = 3:4
            sub_1 = ter_alloys(sub_T(a), 1);
            sub_2 = ter_alloys(sub_T(a), 2);
        
            a_sub(a) = (y_sub*mat_prop(sub_1, 1))+(1-y_sub)*(mat_prop(sub_2, 1));
        end

         %using tertiary values to calaculate final value
        a_sub = (x_sub*(1-x_sub)*(y_sub*a_sub(1)+(1-y_sub)*a_sub(2))+(y_sub*(1-y_sub)*((x_sub*a_sub(3))+(1-x_sub)*a_sub(4))))/(x_sub*(1-x_sub)+y_sub*(1-y_sub));
    end

    %case to handle normal QW materials 
    if val1<10
        a_layer = mat_prop(val1,1);
        C11_layer = mat_prop(val1,2);
        C12_layer = mat_prop(val1,3);
    end

    %case to handle tertiary QW materials
    if 9<val1 && val1<24 
        val1 = val1-9;
        layer_1 = ter_alloys(val1,1);
        layer_2 = ter_alloys(val1,2);
        x_layer = slid_x_layer.Value;
        
        a_layer = (x_layer*mat_prop(layer_1, 1))+(1-x_layer)*(mat_prop(layer_2, 1));
        C11_layer = (x_layer*mat_prop(layer_1, 2))+(1-x_layer)*(mat_prop(layer_2, 2));
        C12_layer = (x_layer*mat_prop(layer_1, 3))+(1-x_layer)*(mat_prop(layer_2, 3));
    end

    %case to handle type 1 quaternary QW materials 
    if 23<val1 && val1<27
        val1=val1-23;
        layer_1 = quat_c1_alloys(val1, 1);
        layer_2 = quat_c1_alloys(val1, 2);
        layer_3 = quat_c1_alloys(val1, 3);

        x_layer = slid_x_layer.Value;
        y_layer = slid_y_layer.Value;
        
        a_layer = (x_layer*mat_prop(layer_1, 1))+(y_layer*(mat_prop(layer_2, 1)))+((1-x_layer-y_layer)*mat_prop(layer_3, 1));
        C11_layer = (x_layer*mat_prop(layer_1, 2))+(y_layer*(mat_prop(layer_2, 2)))+((1-x_layer-y_layer)*mat_prop(layer_3, 2));
        C12_layer = (x_layer*mat_prop(layer_1, 3))+(y_layer*(mat_prop(layer_2, 3)))+((1-x_layer-y_layer)*mat_prop(layer_3, 3));
    end

    %case to handle type 2 quaternary QW materials
    if 26<val1 && val1<30 
        val1=val1-26;
        layer_T(1) = quat_c2_alloys(val1,1);
        layer_T(2) = quat_c2_alloys(val1,2);
        layer_T(3) = quat_c2_alloys(val1,3);
        layer_T(4) = quat_c2_alloys(val1,4);

        x_layer = slid_x_layer.Value;
        y_layer = slid_y_layer.Value;
        
        %calulating values for tertiary alloy 1-4
        
        for a = 1:2
            layer_1 = ter_alloys(layer_T(a), 1);
            layer_2 = ter_alloys(layer_T(a), 2);
        
            a_layer(a) = (x_layer*mat_prop(layer_1, 1))+(1-x_layer)*(mat_prop(layer_2, 1));
            C11_layer(a) = (x_layer*mat_prop(layer_1, 2))+(1-x_layer)*(mat_prop(layer_2, 2));
            C12_layer(a) = (x_layer*mat_prop(layer_1, 3))+(1-x_layer)*(mat_prop(layer_2, 3));
         end

        for a = 3:4
            layer_1 = ter_alloys(layer_T(a), 1);
            layer_2 = ter_alloys(layer_T(a), 2);
        
            a_layer(a) = (y_layer*mat_prop(layer_1, 1))+(1-y_layer)*(mat_prop(layer_2, 1));
            C11_layer(a) = (y_layer*mat_prop(layer_1, 2))+(1-y_layer)*(mat_prop(layer_2, 2));
            C12_layer(a) = (y_layer*mat_prop(layer_1, 3))+(1-y_layer)*(mat_prop(layer_2, 3));
        end

         %using tertiary values to calaculate final value
        a_layer = (x_layer*(1-x_layer)*(y_layer*a_layer(1)+(1-y_layer)*a_layer(2))+(y_layer*(1-y_layer)*((x_layer*a_layer(3))+(1-x_layer)*a_layer(4))))/(x_layer*(1-x_layer)+y_layer*(1-y_layer));
        C11_layer = (x_layer*(1-x_layer)*(y_layer*C11_layer(1)+(1-y_layer)*C11_layer(2))+(y_layer*(1-y_layer)*((x_layer*C11_layer(3))+(1-x_layer)*C11_layer(4))))/(x_layer*(1-x_layer)+y_layer*(1-y_layer));
        C12_layer = (x_layer*(1-x_layer)*(y_layer*C12_layer(1)+(1-y_layer)*C12_layer(2))+(y_layer*(1-y_layer)*((x_layer*C12_layer(3))+(1-x_layer)*C12_layer(4))))/(x_layer*(1-x_layer)+y_layer*(1-y_layer));
     end

    v_layer = C12_layer/(C11_layer+C12_layer);
    b_layer = a_layer/sqrt(2);
    f = (a_layer-a_sub)/a_sub;

    hc = str2double(initial_hc.Value);
    hc_0=hc;

    n=1000;
    tolerance = 1e-10; 
    error_flag = 'none!';

    for i = 1:n
        new_hc = (b_layer/f)*(1/4*pi*(1+v_layer))*(log(hc/b_layer)+1);

        if abs(hc-new_hc) < tolerance
            break
        end
        if i == n
            error_flag = 'reached iteration limit';
        end

        hc=new_hc;
    end

    left_box.Value = {['Initial Value of hc ', num2str(hc_0*0.1), 'nm'], ...
                      ['Iterated Value of hc = ', num2str(new_hc*0.1), 'nm'], ...
                      ['Converged in ', num2str(i), ' iterations!'], ...
                      ['errors - ', error_flag]};
    right_box.Value = {['a_(sub) = ' num2str(a_sub)], ...
                       ['a_(layer) = ' num2str(a_layer)], ...
                       ['b_(layer) = ' num2str(b_layer)], ...
                       ['f = ' num2str(f)], ...
                       ['v_(layer) = ' num2str(v_layer)]};
    
end

% --- SLIDER CALLBACKS --- %
function syncSliderToText(slider, textBox)
    textBox.Value = { num2str(slider.Value) };
end
function syncTextToSlider(textBox, slider)
    val = str2double(textBox.Value);
    if ~isnan(val)
        slider.Value = val;
    end
end