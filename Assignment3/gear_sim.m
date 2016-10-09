clear all, clf, close all, clc, format compact



% Given constants
h = 0.02; 		% Sampling period
r_1 = 90; 		% 90km/h during first half
r_2 = 0; 		% 0km/h during second half
T = [1 2 3 4];
a = [exp(-h./T)]; 	% Different time constants 
t_tot = 30;		% total simulation time, 30s


r = rectpulse([r_1 r_2], t_tot/h/2); 	% Number of samples per element in [r_1, ...] vector
% stem(r)									% Plot the signal, at the moment there is
										% t_tot/h = 1500 samples, 750 samples with 90 as ampl.
										% and 750 samples with 0 as ampl.

i = 1;
q = 1

v = zeros(size(r));
q = zeros(size(r));

s_r = size(r);

v(2) = a(1)*v(1)+(1-a(1))*r(1);


for i = 2:s_r(2)
i
	if (v(i) <= 30) && (v(i) >= v(i-1))					% Gear 1 Accelerating
		% disp('under 30')
		v(i+1) = a(1)*v(i)+(1-a(1))*r(i);
		q(i+1) = 1;
	elseif (v(i) <= 10) && (v(i) <= v(i-1))				% Gear 1 decelerating
		v(i+1) = a(1)*v(i)+(1-a(1))*r(i);
		q(i+1) = 1;

	elseif v(i) >= 30 && v(i) <= 50 && v(i) >= v(i-1)	% Gear 2 Accelerating
		% disp('under 50')
		v(i+1) = a(2)*v(i)+(1-a(2))*r(i);
		q(i+1) = 2;
	elseif v(i) <= 30 && v(i) >= 10 && v(i) <= v(i-1)	% gear 2 decelerating
 		% disp('under 50')
		v(i+1) = a(2)*v(i)+(1-a(2))*r(i);
		q(i+1) = 2;
	elseif v(i) >= 50 && v(i) <= 70 					% gear 3 accelerating			
		% disp('under 70')
		v(i+1) = a(3)*v(i)+(1-a(3))*r(i);
		q(i+1) = 3;
	elseif 												% Gear 3 decelerating
		
	elseif v(i) >= 70 									% gear 4 accelerating
		% disp('över 70')
		v(i+1) = a(4)*v(i)+(1-a(4))*r(i);
		q(i+1) = 4;
	elseif 												% gear 4 decelerating
			
	end
end


stem(v) 			% Speed output
hold on
% stem(r) 			% input output
stem(q)				% gear output

% states= {'q1','q2','q3','q4'};	% States corresponding to 