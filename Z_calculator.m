%extracting data from file
curve_40 = file_integrator("40mA curve.txt");
curve_50 = file_integrator("50mA curve.txt");
curve_60 = file_integrator("60mA curve.txt");
curve_70 = file_integrator("70mA curve.txt");
curve_80 = file_integrator("80mA curve.txt");
curve_90 = file_integrator("90mA curve.txt");
curve_100 = file_integrator("100mA curve.txt");

intergrated_current = [curve_40,log(0.04);
                       curve_50,log(0.05);
                       curve_60,log(0.06);
                       curve_70,log(0.07);
                       curve_80,log(0.08);
                       curve_90,log(0.09);
                       curve_100,log(0.1)];

x = intergrated_current(:,1);
y = intergrated_current(:,2);

%calculating line of best fit
best_fit = polyfit(x, y, 1);
y_fit = polyval(best_fit, x);

%plotting output
hold on
plot(x, y, 'o', 'DisplayName', 'Integrated Current')
plot(x, y_fit, 'DisplayName', ['Y=',num2str(best_fit(1)),'X+',num2str(best_fit(2))])
legend show

function output = file_integrator(file_name)
    %extracting data from file
    curve = cell2mat(readcell(file_name));

    %filtering data
    [m n] = size(curve);
    for i=1:m
        if (curve(i,1)<1600)
            curve(i,:) = 0;
        end
        if (curve(i,1)>2500)
            curve(i,:) = 0;
        end
    end
    disp(curve)
    
    %calculating data points
    output = log(sqrt(trapz(curve(:,2), curve(:,1))));
end

title('Plot of Integrated Luminescence against Current', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Integrated Luminescence', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Current (A)', 'FontSize', 12, 'FontWeight', 'bold');