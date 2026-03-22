curve_40 = file_integrator("40mA curve.txt");
curve_60 = file_integrator("60mA curve.txt");
curve_80 = file_integrator("80mA curve.txt");
curve_100 = file_integrator("100mA curve.txt");
curve_120 = file_integrator("120mA curve.txt");
curve_140 = file_integrator("140mA curve.txt");
curve_160 = file_integrator("160mA curve.txt");
curve_180 = file_integrator("180mA curve.txt");
curve_200 = file_integrator("200mA curve.txt");

intergrated_current = [curve_40,log(0.04);
                       curve_60,log(0.06);
                       curve_80,log(0.08);
                       curve_100,log(0.1);
                       curve_120,log(0.12);
                       curve_140,log(0.14);
                       curve_160,log(0.16);
                       curve_180,log(0.18);
                       curve_200,log(0.20)];

x = intergrated_current(:,1);
y = intergrated_current(:,2);

best_fit = polyfit(x, y, 2);
y_fit = polyval(best_fit, x);

hold on
plot(x, y, 'o', 'DisplayName', 'Integrated Current')
%plot(x, y_fit, 'DisplayName', ['Y=',num2str(best_fit(1)),'X^2+',num2str(best_fit(2)),'X+',num2str(best_fit(3))])
legend show

function output = file_integrator(file_name)
    curve = cell2mat(readcell(file_name));

    [m n] = size(curve);
    for i=1:m
        if (curve(i,1)<1000)
            curve(i,:) = 0;
        end
        if (curve(i,1)>3800)
            curve(i,:) = 0;
        end
    end
    disp(curve)

    output = log(sqrt(trapz(curve(:,2), curve(:,1))));
end

title('Plot of Integrated Luminescence against Current', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Integrated Luminescence', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Current (A)', 'FontSize', 12, 'FontWeight', 'bold');