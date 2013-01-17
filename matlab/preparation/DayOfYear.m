function nthDay = DayOfYear(month,day)
%   Calculate the days passed after 31.12
    month_add = [1,-2,1,0,1,0,1,1,0,1,0,1];
    nthDay = ((month-1)*30);
    for k=1:month-1
        nthDay = nthDay + month_add(1,k);
    end
    nthDay = nthDay + day;
end