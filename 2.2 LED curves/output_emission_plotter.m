hold("on")
extract_and_plot("40mA curve.txt");
extract_and_plot("50mA curve.txt");
extract_and_plot("60mA curve.txt");
extract_and_plot("70mA curve.txt");
extract_and_plot("80mA curve.txt");
extract_and_plot("90mA curve.txt");
extract_and_plot("100mA curve.txt");



title('Plot of Luminescence against Frequency for Varying Currents', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Wavelength (nm)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Intensity', 'FontSize', 12, 'FontWeight', 'bold');
hold("off")


function extract_and_plot(file_name)
    curve = cell2mat(readcell(file_name));

    curve_name = extractBetween(file_name, 1, min(10, strlength(file_name)));
    peak_name = extractBetween(file_name, 1, min(3, strlength(file_name)));

    plot(curve(:,1), curve(:,2), 'DisplayName', curve_name, 'LineWidth', 1.5)
    curve = sortrows(curve, 1);
    [pks,locs] = findpeaks(curve(:,2), curve(:,1));
    plot(locs, pks, 'o', 'DisplayName',peak_name + ' peak')
end

