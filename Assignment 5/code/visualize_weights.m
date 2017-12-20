% Nist 26

load('nist26_model_lr01.mat')
W1 = W{1};
W1_init = -0.1 + 0.2*rand(400,1024);
W_montage = zeros(32,32,1,size(W1,1));
W_montage_init = zeros(32,32,1,size(W1,1));

for i=1:size(W1,1)
    curr_W1 = W1(i,:);
    norm_W1 = mat2gray(curr_W1);
    %norm_W1 = (curr_W1-min(curr_W1(:)))./(max(curr_W1(:))-min(curr_W1(:)));
    W_montage(:,:,1,i) = reshape(norm_W1,[32,32,1]);
    curr_W1_init = W1_init(i,:);
    norm_W1_init = mat2gray(curr_W1_init);
    %norm_W1_init = (curr_W1_init-min(curr_W1_init(:)))./(max(curr_W1_init(:))-min(curr_W1_init(:)));
    W_montage_init(:,:,1,i) = reshape(norm_W1_init,[32,32,1]);
    %W_montage_init(:,:,1,i) = reshape(W1_init(i,:),[32,32,1]);
end
montage(W_montage)
montage(W_montage_init)
imshow(W_montage(:,:,1,1))

% Nist 36

load('nist36_model_lr01.mat')
W1 = W{1};
W1_init = -0.1 + 0.2*rand(size(W1));
W_montage = zeros(32,32,1,size(W1,1));
W_montage_init = zeros(32,32,1,size(W1,1));

for i=1:size(W1,1)
    curr_W1 = W1(i,:);
    norm_W1 = mat2gray(curr_W1);
    %norm_W1 = (curr_W1-min(curr_W1(:)))./(max(curr_W1(:))-min(curr_W1(:)));
    W_montage(:,:,1,i) = reshape(norm_W1,[32,32,1]);
    curr_W1_init = W1_init(i,:);
    norm_W1_init = mat2gray(curr_W1_init);
    %norm_W1_init = (curr_W1_init-min(curr_W1_init(:)))./(max(curr_W1_init(:))-min(curr_W1_init(:)));
    W_montage_init(:,:,1,i) = reshape(norm_W1_init,[32,32,1]);
    %W_montage_init(:,:,1,i) = reshape(W1_init(i,:),[32,32,1]);
end
montage(W_montage)
montage(W_montage_init)
imshow(W_montage(:,:,1,1))