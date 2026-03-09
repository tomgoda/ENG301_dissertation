%Modelling Semiconducor Bandgaps Using Krijins Mathmatical Method
%paper used - Calculation of critical layer thickness versus lattice mismatch for GexSi1−x/Si strained‐layer heterostructures
%https://pubs.aip.org/aip/apl/article/47/3/322/1023078/Calculation-of-critical-layer-thickness-versus

fig = uifigure("Position",[50,50,1400,800]);
format long

% --- INTERFACE ELEMENTS --- %
Title = uilabel(fig,"Text",'Critical Layer Thickness Solver - Krijn Constants - Both Methods', "Position",[50,650,400,30]);
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

%axis to plot output
ax = uiaxes(fig, "Position",[550, 40, 800, 800]);

%slider for x_sub
text_x_sub = uitextarea(fig,"Position",[40,130,100,30]);
lab_slid_x_layer = uilabel(fig, "Text","x sub material","Position",[50,160,140,40]);

%slider for y_sub
text_y_sub = uitextarea(fig,"Position",[40,190,100,30]);
lab_slid_y_sub = uilabel(fig, "Text","y sub  material","Position",[50,220,140,40]);

%slider for changing_layer_min
text_layer_min = uitextarea(fig,"Position",[160,130,100,30]);
lab_slid_x_layer_min = uilabel(fig, "Text","X/Y layer material min","Position",[150,160,120,40]);

%slider for changing_layer_max
text_layer_max = uitextarea(fig,"Position",[280,130,100,30]);
lab_slid_x_layer_max = uilabel(fig, "Text","X/Y layer material max","Position",[270,160,130,40]);

%slider for fixed_layer
text_layer_fixed = uitextarea(fig,"Position",[160,190,100,30]);
lab_slid_y_layer_min = uilabel(fig, "Text","Fixed parameter value","Position",[160,220,120,40]);

%check box to calcaulte across x or y
check_box = uidropdown(fig, "Position", [280, 190, 100, 30], "Items", ["X","Y"],"ItemsData", 1:2, "Value", 1);

%slider for a
text_a = uitextarea(fig,"Position",[400,130,100,30]);
lab_a = uilabel(fig, "Text","intervals in x or y","Position",[400,160,120,40]);

%adding a calculate buton
b = uibutton(fig, "Text","Plot!","Position",[40,350,100,40]);

%adding a clear axis button
cl_b = uibutton(fig, "Text","Clear axis!","Position",[160,350,100,40]);

initial_hc = uitextarea(fig,"Position",[400,350,100,30]);
lab_initial_hc = uilabel(fig, "Text","Initial hc","Position",[420,370,140,40]);

b.ButtonPushedFcn = @(src,event) calc_plot_output(text_a, check_box, ax, text_layer_min,  text_layer_max, text_layer_fixed, mat1, mat2, initial_hc, text_x_sub, text_y_sub);
cl_b.ButtonPushedFcn = @(src,event) clear_axis(ax);



global output_array;
global h;
h=1;


function clear_axis(ax)
    cla(ax)
end

% --- PLOT CALLBACK FUNCTION --- %
function calc_plot_output(text_a, check_box, ax, text_layer_min,  text_layer_max, text_layer_fixed, mat1, mat2, initial_hc, text_x_sub, text_y_sub)
    global output_array;
    global h;
    values=str2double(text_a.Value);

    output_array = zeros(1,values);
    x_sub = str2double(text_x_sub.Value);
    y_sub = str2double(text_y_sub.Value);
    
    ax.YScale = 'log';
    hold(ax, 'on');
    
    if check_box.Value == 1
        x=linspace(str2double(text_layer_min.Value),str2double(text_layer_max.Value),values);
        y=str2double(text_layer_fixed.Value);
        
        for k=1:values
            x_layer=x(k);
            y_layer=y;
            update_calc(mat1,mat2,x_sub,y_sub,x_layer, y_layer, initial_hc, k);
        end

        plot(ax,x, output_array, 'DisplayName',['[', num2str(h), '] - y = ', num2str(y_layer)])
        ylim(ax, 'auto');
        xlim(ax, 'auto');
        xlabel(ax, 'X composition in layer');   
        ylabel(ax, 'Critical layer thickness, Angstroms');   
    else
        y=linspace(str2double(text_layer_min.Value),str2double(text_layer_max.Value),values);
        x=str2double(text_layer_fixed.Value);

        for k=1:values
            x_layer=x;
            y_layer=y(k);
            update_calc(mat1,mat2,x_sub,y_sub,x_layer, y_layer, initial_hc, k);
        end
      
        plot(ax, y, output_array, 'DisplayName',['[', num2str(h), '] - x = ', num2str(x_layer)])
        ylim(ax, 'auto');
        xlim(ax, 'auto');
        xlabel(ax, 'Y composition in layer');   
        ylabel(ax, 'Critical layer thickness, Angstroms');   
    end
    h=h+1;
    legend(ax, 'show', 'Location', "northeast");
     
end
% --- CALCULATE FUNCTION --- %
function update_calc(mat1, mat2, x_sub, y_sub, x_layer, y_layer, initial_hc, k)
    global output_array;

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
        a_sub = (x_sub*mat_prop(sub_1, 1))+(1-x_sub)*(mat_prop(sub_2, 1));
    end
    
    %case to consider quaternary case 1 alloy substrates
    if 23<val2 && val2<27
        val2=val2-23;
        sub_1 = quat_c1_alloys(val2, 1);
        sub_2 = quat_c1_alloys(val2, 2);
        sub_3 = quat_c1_alloys(val2, 3);

        a_sub = (x_sub*mat_prop(sub_1, 1))+(y_sub*(mat_prop(sub_2, 1)))+((1-x_sub-y_sub)*mat_prop(sub_3, 1));
    end

    %case to consider quaternary case 2 alloy substrates
    if 26<val2 && val2<30 
        val2=val2-26;
        sub_T(1) = quat_c2_alloys(val2,1);
        sub_T(2) = quat_c2_alloys(val2,2);
        sub_T(3) = quat_c2_alloys(val2,3);
        sub_T(4) = quat_c2_alloys(val2,4);

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
    output_9 = -1;
    output_7 = -1;

    for i = 1:n
        new_hc = ((1-v_layer)/(1+v_layer))*(1/16*pi*sqrt(2))*((b_layer^2)/a_layer)*((1/f^2)*log(hc/b_layer));

        if abs(hc-new_hc) < tolerance
            output_7=new_hc;
            break
        end
        if i == n
            break
        end

        hc=new_hc;
    end
    
    
    hc = str2double(initial_hc.Value);
    for i = 1:n
        new_hc = (b_layer/f)*(1/4*pi*(1+v_layer))*(log(hc/b_layer)+1);

        if abs(hc-new_hc) < tolerance
            output_9 =new_hc;
            break
        end
        if i == n
            break
        end

        hc=new_hc;
    end
   

    if output_9 > 0 && output_7 > 0
        output = (output_7+output_9)/2;
    elseif output_9 > 0
        output=output_9;
    elseif output_7 > 0
        output=output_7;
    else
        output=0;
        disp('Didnt converge for either!');
    end
    output_array(k)=output/100; %fix this!!
end
