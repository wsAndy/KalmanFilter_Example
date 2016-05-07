function out= getInitValue(src)

text = get(src,'Tag');
switch text
    case 'edt_var'
        if(judge(src))
            out = disconnect(src);

        else
            out = [];
        end
    otherwise
        out = str2double(get(src,'String'));

end

end

function out = disconnect(src)
 data = get(src,'String');
 dot_pos = strfind(data,',');
 out = [str2double(data(1:dot_pos-1)) 0;0 str2double(data(dot_pos+1:end))];
end

function out = judge(src)
data = get(src,'String');
dot_size = size(strfind(data,','));
if(dot_size(1,2)~=1)
    out = 0;
else
    out = 1;
end
end