function [initial_centroids, eval] = k_means( a,initial_centroids,iter )
%a=Dataset
%It is assumed that the last column of the Dataset will have the true cluster values
%initial_centroids = Randomised cluster centers
%iter=Total number of iterations to run the algo
val=zeros(size(a,1),1);
obj=zeros(iter,1);
val2=zeros(size(a,1),size(initial_centroids,1));
for i=1:iter
    no=zeros(size(initial_centroids,1));
    avg=zeros(size(initial_centroids,1),size(initial_centroids,2));
    for j=1:size(a,1)

        for k=1:size(initial_centroids,1)

            val2(j,k)=norm(a(j,1:(size(a,2)-1)) - initial_centroids(k,1:size(initial_centroids,2)));
        end
        [M,I]=min(val2(j,:));
        obj(i,1)=obj(i,1)+M;
        val(j,1);
        val(j,1)=I;
        avg(I,:)=avg(I,:)+a(j,1:(size(a,2)-1));
        no(I)=no(I)+1;
    end
    for j=1:size(initial_centroids,1)
       initial_centroids(j,:)=avg(j,:)/no(j);
    end

end
 eval=[0 0 0 0];
 [ar, ri, mi, hi]=valid_RandIndex(val,a(:,size(a,2):size(a,2))) ;
 eval(1)=mi;
 eval(2)=ami(val,a(:,size(a,2):size(a,2)));
 eval(3)=ri;
 eval(4)=ar;
mapped=tsne(a,val,k,size(a,2)-1,30)
f = figure();
clr='rgbymck';
SYM = 'ooooooo';
%gscatter(mapped(:,1),mapped(:,2),a(:,size(a,2):size(a,2)),clr,SYM);
gscatter(mapped(:,1),mapped(:,2),val,clr,SYM);
saveas(f,'my_values.png');
obj=obj(1:20,:);
%plot(obj);
end
