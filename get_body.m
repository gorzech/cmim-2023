function body = get_body(sys, body_name)
%GET_BODY Gets the body based on its name
body = [];
for b = sys.bodies
    if b.name == body_name
        body = b;
        break;
    end
end

if isempty(body)
    error("The body with name %s does not exist in the system.", body_name);
end
