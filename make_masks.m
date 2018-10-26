function make_masks()

    canvas_dim       = 900;     % size of the output mask in pixels
    ratio            = 10;      % maximum distance (in percent) between each 2 point of triangle
    num_of_masks     = 100;     % how many masks to create (all the masks will be on ./output)
    num_of_triangles = 10000;   % hoe many triangles to draw on each mask 
    
    
    [window, screenRect]=Screen('OpenWindow',0);
    x0 = screenRect(3)/2;
    y0 = screenRect(4)/2;

    addition        = 1.2;
    canvas_dim_fix  = canvas_dim*addition;           

    Screen('FrameRect', window, [0, 0, 0], [x0-canvas_dim_fix/2, y0-canvas_dim_fix/2, x0+canvas_dim_fix/2, y0+canvas_dim_fix/2], 5);
    for img = 1:num_of_masks
        for i=1:num_of_triangles
            width = canvas_dim_fix/20+randi(canvas_dim_fix/(2*ratio));
            hight = canvas_dim_fix/20+randi(canvas_dim_fix/(2*ratio));
            ori = randi(4);
            switch ori
                case 1
                    x_l = x0-canvas_dim_fix/2+randi(canvas_dim_fix-canvas_dim_fix/ratio);
                    y_u = y0-canvas_dim_fix/2+randi(canvas_dim_fix-canvas_dim_fix/ratio);
                    points = [x_l, y_u        
                               x_l+width, y_u 
                               x_l+width/2, y_u+hight ];
                case 2
                    x_l = x0-canvas_dim_fix/2+randi(canvas_dim_fix-canvas_dim_fix/ratio);
                    y_u = y0+canvas_dim_fix/2-randi(canvas_dim_fix-canvas_dim_fix/ratio);
                    points = [x_l, y_u         
                               x_l+width, y_u  
                               x_l+width/2, y_u-hight ];      
                case 3
                    x_l = x0-canvas_dim_fix/2+randi(canvas_dim_fix-canvas_dim_fix/ratio);
                    y_u = y0-canvas_dim_fix/2+randi(canvas_dim_fix-canvas_dim_fix/ratio);
                    points = [
                           x_l, y_u       
                           x_l, y_u+hight      
                           x_l+width, y_u+hight/2];     
                case 4
                    x_l = x0+canvas_dim_fix/2-randi(canvas_dim_fix-canvas_dim_fix/ratio);
                    y_u = y0-canvas_dim_fix/2+randi(canvas_dim_fix-canvas_dim_fix/ratio);
                    points = [
                           x_l, y_u       
                           x_l, y_u+hight       
                           x_l-width, y_u+hight/2];    
            end
            Screen('FillPoly',window, rand(3,1)*255, points);
        end
        Screen('Flip',window);
        imageArray = Screen('GetImage', window, [x0-canvas_dim/2, y0-canvas_dim/2, x0+canvas_dim/2, y0+canvas_dim/2]);
        imwrite(imageArray, ['output/mask_' num2str(img) '.png']);
    end     
    Screen('CloseAll');
end
