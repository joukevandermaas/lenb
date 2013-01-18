function [ numeric_speeds ] = clean_speeds( text_speeds )
    useful_speeds = [];
    crappy_speeds = [];
    numeric_speeds = zeros(length(text_speeds), 1);
    for i = 1:length(text_speeds)
       if (text_speeds{i} ~= '?')
           speed = str2double(text_speeds(i));
           useful_speeds = [useful_speeds speed];
           numeric_speeds(i) = speed;
       else
           crappy_speeds = [crappy_speeds i];
       end
    end
    
    for i = 1:length(crappy_speeds)
        if (crappy_speeds(i) == 1)
            numeric_speeds(1) = numeric_speeds(2);
        elseif (crappy_speeds(i) == length(numeric_speeds))
            numeric_speeds(end) = numeric_speeds(end-1);
        else
            numeric_speeds(crappy_speeds(i)) = ...
                (numeric_speeds(crappy_speeds(i) - 1) + ...
                numeric_speeds(crappy_speeds(i) + 1)) / 2;
        end
    end
end

