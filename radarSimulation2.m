function radarSimulation2 (npts, sector_width)
    close all; clearvars -except npts sector_width; clc;

    r = 1; % radio (alcance del radar)
    alfa = 0:0.01:2*pi;
    x = r * cos(alfa);
    y = r * sin(alfa);

    % Generar puntos aleatorios
    X = fnPuntosAzar(npts);

    min_points = npts;
    min_sector_start_angle = 0;

    num_sectors = ceil(360 / sector_width); % Número de sectores
    points_in_sectors = zeros(1, num_sectors); % Arreglo para almacenar la cantidad de puntos en cada sector

    figure;
    % Evaluar los sectores
    for i = 0:num_sectors-1
        clf; % Limpiar el escenario
        plot(x, y, 'r-', 'LineWidth', 2)
        axis equal
        grid on
        hold on

        % Definir el ángulo del sector actual
        start_angle = i * sector_width * pi / 180; % Inicio del sector en radianes
        end_angle = start_angle + sector_width * pi / 180; % Fin del sector en radianes

        % Dibujar el sector
        sector_alfa = linspace(start_angle, end_angle, 100);
        sector_x = [0, cos(sector_alfa), 0];
        sector_y = [0, sin(sector_alfa), 0];
        fill(sector_x, sector_y, 'g', 'FaceAlpha', 0.3); % Sector semitransparente

        % Contar puntos en el sector
        angles = atan2(X(:,2), X(:,1));
        angles(angles < 0) = angles(angles < 0) + 2*pi; % Asegurarse de que los ángulos están en [0, 2pi)
        in_sector = (angles >= start_angle) & (angles < end_angle);
        num_points_in_sector = sum(in_sector);
        points_in_sectors(i + 1) = num_points_in_sector; % Almacenar la cantidad de puntos en el sector

        % Mostrar los puntos
        plot(X(:,1), X(:,2), 'b.', 'MarkerSize', 7);
        plot(X(in_sector, 1), X(in_sector, 2), 'ro', 'MarkerSize', 10); % Puntos en el sector en rojo

        % Mostrar la cuenta de puntos en el sector en la figura
        title(sprintf('Puntos en el sector %d-%d grados: %d', round(start_angle*180/pi), round(end_angle*180/pi), num_points_in_sector));

        drawnow; % Actualizar la figura inmediatamente
        pause(0.5); % Pausa más larga para visualización
    end

    % Encontrar el sector con menos puntos
    [min_points, min_sector_idx] = min(points_in_sectors);
    min_sector_start_angle = (min_sector_idx - 1) * sector_width;
    min_sector_end_angle = min_sector_start_angle + sector_width;

    % Mostrar el resultado final
    disp('Cantidad de puntos en cada sector:');
    disp(points_in_sectors);
    fprintf('Sector con la menor cantidad de puntos: %d-%d grados\n', min_sector_start_angle, min_sector_end_angle);
    fprintf('Cantidad de puntos en el sector con menos puntos: %d\n', min_points);

    % Regresar al sector con menos puntos
    clf; % Limpiar el escenario
    plot(x, y, 'r-', 'LineWidth', 2)
    axis equal
    grid on
    hold on

    % Definir el ángulo del sector con menos puntos
    start_angle = min_sector_start_angle * pi / 180; % Inicio del sector en radianes
    end_angle = start_angle + sector_width * pi / 180; % Fin del sector en radianes

    % Dibujar el sector con menos puntos
    sector_alfa = linspace(start_angle, end_angle, 100);
    sector_x = [0, cos(sector_alfa), 0];
    sector_y = [0, sin(sector_alfa), 0];
    fill(sector_x, sector_y, 'g', 'FaceAlpha', 0.3); % Sector semitransparente

    % Mostrar los puntos
    angles = atan2(X(:,2), X(:,1));
    angles(angles < 0) = angles(angles < 0) + 2*pi; % Asegurarse de que los ángulos están en [0, 2pi]
    in_sector = (angles >= start_angle) & (angles < end_angle);

    plot(X(:,1), X(:,2), 'b.', 'MarkerSize', 10);
    plot(X(in_sector, 1), X(in_sector, 2), 'ro', 'MarkerSize', 10); % Puntos en el sector en rojo

    % Mostrar la cuenta de puntos en el sector en la figura
    title(sprintf('Sector con la menor cantidad de puntos: %d-%d grados\nCantidad de puntos: %d', ...
        round(start_angle*180/pi), round(end_angle*180/pi), min_points));

    drawnow; % Actualizar la figura inmediatamente

end

