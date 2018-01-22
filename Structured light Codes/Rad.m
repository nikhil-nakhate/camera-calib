function A = Rad(Pattern)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%  p1 = -386.23;
%   p2 = 1580.8;
%   p3 = -2704.1;
%   p4 = 2505.8;
%   p5 = -1362.1;
%   p6 = 437.81;
%   p7 = -77.661;
%   p8 = 6.897;
%   p9 = -0.24963;
%   p10 = 0.0050475;
%   poly=[p1 p2 p3 p4 p5 p6 p7 p8 p9 p10];
%   p1 = -1.8586;
%   p2 = 2.8249;
%   p3 = 0.016628;
%   p4 = 0.042992;
%   p5 = 0.0085281;
%    poly=[p1 p2 p3 p4 p5];
 p1 = -63.092
  p2 = 198.37
  p3 = -244.79
  p4 = 148.99
  p5 = -44.758
  p6 = 6.685
  p7 = -0.41692
  p8 = 0.0090975
  poly=[p1 p2 p3 p4 p5 p6 p7 p8 ];
P{1}=Pattern;
 Pc{1}=zeros(size(P{1}));
for jj=1:size(P{1},2)
    poly1=poly;
    poly1(end)=poly1(end)-P{1}(1,jj); 
    one = roots(poly1);
    sel = one == real(one); % choose only real elements

    only_reals = one( sel ); 
    x=only_reals(only_reals>=0 & only_reals<=1);
    if (isempty(x))
        if (P{1}(1,jj)>=0.5)
            Pc{1}(1,jj)=real(one(1));
        else
            if real(one(4))<0
                Pc{1}(1,jj)=0;
            else
                Pc{1}(1,jj)=real(one(7));
            end
        end
    else 
        Pc{1}(1,jj)=x(1);
    end
    A=Pc{1}(1,:);
    %A = repmat(A, [1080, 1]);
    %A=im2uint16(A);
end


end

