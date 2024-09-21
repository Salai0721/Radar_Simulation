function X = fnPuntosAzar(npts)
  ang = 2*pi*rand(npts,1); %angulos en radianes
  mag = rand(npts,1); %radios

  %conversion de polares a rectangulares
  x = mag.*cos(ang); %se le pone un punto porque magnitud es un vector
  y = mag.*sin(ang);
  X = [x y]; %matriz aumentada
  end
