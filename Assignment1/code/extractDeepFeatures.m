function out = extractDeepFeatures(net, I)
    
    I = imresize(I,[224,224]);
%     I = cast(I,'like',1.1);
    out = I;
    input = I;
    
%     Layer = netraint.Layers(i);
%     while(~strcmp(Layer.Name,'relu7'))
    for i=1:36
    
%         Layer = net.Layers(i);
        
        layer = extractAfter(class(net.Layers(i)),15);
        i

        switch layer

            case('ImageInputLayer')

                m = activations(net,zeros(224,224,3),'input','OutputAs','channels');
%                 m = cast(m,'like',1.1);
                input = cast(input,'like',m);
                out = mean_remove(input,m);
                input = out;
%                 i = i+1;
                size(out)

            case('Convolution2DLayer')

                conv2DClass = net.Layers(i);
                h = conv2DClass.Weights;
                b = conv2DClass.Bias;
%                 h = cast(conv2DClass.Weights, 'like', 1.1);
%                 b = cast(conv2DClass.Bias, 'like', 1.1);
                conv_stride = conv2DClass.Stride;
                out = multichannel_conv2(input, h, b);            
                out = stride(out,conv_stride);
                input = out;
%                 i = i+1;
                size(out)

            case('ReLULayer')

                out = relu(input);
                input = out;
%                 i = i+1;
                size(out)

            case('MaxPooling2DLayer')

                input = cast(input, 'like', 1.1);
                MaxPoolClass = net.Layers(i);
                sz = MaxPoolClass.PoolSize;
                sz = cast(MaxPoolClass.PoolSize, 'like', 1.1);
                out = max_pool(input, sz);
                maxPool_stride = MaxPoolClass.Stride;
                out = stride(out,maxPool_stride);
                input = out;
%                 i = i+1;
                size(out)

            case('FullyConnectedLayer')

                input = out;
                if ndims(input>2)
                    input_flat = reshape(input, [size(input,1)*size(input,2)*size(input,3),1]);
                else
                    input_flat = input;
                end
                fcClass = net.Layers(i);
                W = fcClass.Weights;
                b = fcClass.Bias;
                out = fully_connected(input_flat,W,b);
                size(out)
                input = out;
%                 i = i+1;
        end
        
    end

    

end