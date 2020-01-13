function Allfig = Plot_ALL_Day(ALL_SOH)
%% Takes in the SOH data and plots all the data from the entire deployment in hourly increments

%% Plots the long and lat at hourly intervals

%% sets up axes
clear figure

xstep = .40;
ystep = .13;
xpos = [0.05 .55];
ypos = [0.05 .25 .45 .65 .85];
ax = zeros(length(xpos),length(ypos));
for ix = 1:length(xpos)
    for iy = 1:length(ypos)
       ax(ix,iy) = axes('Position',[xpos(ix) ypos(iy) xstep ystep]);
    end
end
set(gcf, 'Position', get(0,'ScreenSize'));
StartTime = unique(floor(ALL_SOH.Time));


%% Check for Horizon or compact for mass positions. 
%For compact, populates mass2 and mass 3 with badval =-999
HCcheck = fliplr(ALL_SOH.name);
badval =NaN;% make sure badval == badval in Concat_SOH function
if HCcheck(2) == 'C'
    ALL_SOH.mass2(1:length(ALL_SOH.Time))=badval;
    ALL_SOH.mass3(1:length(ALL_SOH.Time))=badval;
end
    
   
%% Etablishes nanmean values for every daily for the SOH fields
for i = 1:length(StartTime)
    lb = find(ALL_SOH.Time == StartTime(i));
    ub = find(ALL_SOH.Time == StartTime(i)+1);
    
    
    sertime(i)= nanmean(ALL_SOH.Time(lb:ub)); %nanmean  time (serial time)
    hmsat(i) = nanmean(ALL_SOH.Sat(lb:ub));%nanmean hourly sat
    hmSupply_Volt(i) = nanmean(ALL_SOH.Supply_Voltage(lb:ub));%nanmean  Supply Voltage
    hmCurrent(i) = nanmean(ALL_SOH.Current(lb:ub));%nanmean  Current
    hmTemp(i) = nanmean(ALL_SOH.Temp(lb:ub)); %nanmean Temp
    hmTime_Status(i) = nanmean(ALL_SOH.Time_Status(lb:ub));%nanmean  Time status
    hmLock(i) = nanmean(ALL_SOH.Lock(lb:ub));%nanmean  Lock
    hmTime_Un(i) = nanmean(ALL_SOH.Time_Uncertainty(lb:ub));%nanmean  Time Uncertainty
    hmTime_Error(i) = nanmean(ALL_SOH.Time_Error(lb:ub));%nanmean  Time Error
    hmTime_Quality(i) = nanmean(ALL_SOH.Time_Quality(lb:ub));%nanmean  time quality
    hmMass1(i) = nanmean(ALL_SOH.mass1(lb:ub));%nanmean  Voltage 
    hmMass2(i) = nanmean(ALL_SOH.mass2(lb:ub));%nanmean  Voltage 
    hmMass3(i) = nanmean(ALL_SOH.mass3(lb:ub));%nanmean  Voltage 
end
xtickval = [min(sertime):14:max(sertime)]; % define intervals for x values on plots
%Plot daily sats
plot(ax(1,1),sertime,hmsat,'*');

    title(ax(1,1),'Num Satelites during deployment')
    xlabel(ax(1,1),'Date dd mm yyyy')
    ylabel(ax(1,1),'Num Satellites')
    xticks(ax(1,1),xtickval);
    datetick(ax(1,1),'x', 'dd mm YYYY', 'keepticks')
    ylim(ax(1,1),[0,max(hmsat)+1])

% Plot Timing stuff
plot(ax(1,2),sertime,hmTime_Un,'*');

    title(ax(1,2),'Time Uncertainty during deployment')
    xlabel(ax(1,2),'Date dd mm yyyy')
    ylabel(ax(1,2),'Time Uncertainty (nano seconds)')
    xticks(ax(1,2),xtickval)
    datetick(ax(1,2),'x', 'dd mm YYYY', 'keepticks')
    xlim(ax(1,2),[min(sertime) max(sertime)])
 
plot(ax(1,3),sertime,hmTime_Error,'*');

    title(ax(1,3),'Timing Error during deployment')
    xlabel(ax(1,3),'Date dd mm yyyy')
    ylabel(ax(1,3),'Timimg Error (nano seconds)')
    xticks(ax(1,3),xtickval)
    datetick(ax(1,3),'x', 'dd mm YYYY', 'keepticks')
    xlim(ax(1,3),[min(sertime) max(sertime)])
    
plot(ax(1,4),sertime,hmTime_Status,'*');

    title(ax(1,4),'Timing Status')
    xlabel(ax(1,4),'Date dd mm yyyy') 
    ylabel(ax(1,4),'Status')   
    xticks(ax(1,4),xtickval)
    datetick(ax(1,4),'x', 'dd mm YYYY', 'keepticks')
    xlim(ax(1,4),[min(sertime) max(sertime)])
   
plot(ax(1,5),sertime,hmTime_Quality,'*');

    title(ax(1,5),'Timing Quality (0-100)')
    xlabel(ax(1,5),'Date dd mm yyyy') 
    ylabel(ax(1,5),'Quality')  
    ylim(ax(1,5),[min(hmTime_Quality)-2 max(hmTime_Quality)+2])
    xticks(ax(1,5),xtickval)
    datetick(ax(1,5),'x', 'dd mm YYYY', 'keepticks')
    xlim(ax(1,5),[min(sertime) max(sertime)])
   
% Plot GPS stuff  
plot(ax(2,1),sertime,(hmLock),'g*');

    xlabel(ax(2,1),'Time (Serial Time)')
    ylabel(ax(2,1),'Locking Status')
    title(ax(2,1),'0= nolock for day')
    xticks(ax(2,1),xtickval)
    datetick(ax(2,1),'x', 'dd mm YYYY', 'keepticks')
    ylim(ax(2,1),[0 3])
    xlim(ax(2,1),[min(sertime) max(sertime)])

%Plots for instrument stuff
plot(ax(2,2),sertime,hmTemp,'*');

    title(ax(2,2),'Temperature')
    xlabel(ax(2,2),'Date dd mm yyyy')
    ylabel(ax(2,2),'Temperature (Celsius)')
    xticks(ax(2,2),xtickval)
    datetick(ax(2,2),'x', 'dd mm YYYY', 'keepticks')
    xlim(ax(2,2),[min(sertime) max(sertime)])

plot(ax(2,3),sertime,hmCurrent,'*');

    title(ax(2,3),'Current')
    xlabel(ax(2,3),'Date dd mm yyyy')
    ylabel(ax(2,3),'Current (mA)')
    xticks(ax(2,3),xtickval)
    datetick(ax(2,3),'x', 'dd mm YYYY', 'keepticks')
    xlim(ax(2,3),[min(sertime) max(sertime)]) 
   
plot(ax(2,4),sertime,hmCurrent,'*');
    title(ax(2,4),'Supply Voltage')
    xlabel(ax(2,4),'Date dd mm yyyy')
    ylabel(ax(2,4),'Supply Voltage (V)')
    xticks(ax(2,4),xtickval)
    datetick(ax(2,4),'x', 'dd mm YYYY', 'keepticks')
    xlim(ax(2,4),[min(sertime) max(sertime)])
    
%Plot for mass positions
plot(ax(2,5),sertime,hmMass1,'*');

    title(ax(2,5),'Mass Positions')
    xlabel(ax(2,5),'Date dd mm yyyy')
    ylabel(ax(2,5),'Voltage (\muV)')
    xticks(ax(2,5),xtickval)
    datetick(ax(2,5),'x', 'dd mm YYYY', 'keepticks')
    xlim(ax(2,5),[min(sertime) max(sertime)])
    hold on 
        plot(ax(2,5),sertime,hmMass2,'g*')
        plot(ax(2,5),sertime,hmMass3,'r*')
    hold off
        legend(ax(2,5),{'Mass1','Mass2','Mass3'})
%% Link axes and give a title that specifies the stations    
linkaxes(ax,'x')
titlename = ['SOH data',' ', ALL_SOH.name,' (Daily Averages)'];
set(findall(gcf,'-property','FontSize'),'FontSize',14)
suptitle(titlename)



 Allfig = 1;
    
    
    
    
    
    
    