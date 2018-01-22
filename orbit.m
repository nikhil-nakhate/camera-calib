
function orbit(deg)
[az el] = view;
rotvec = 0:deg/10:deg;
for i = 1:length(rotvec)
    view([az el+rotvec(i)])
    drawnow
    keyboard
end
