function cost_value = cost_function(data, label)
    sum1=0; sum2=0; sum3=0; sum4=0; sum5=0; sum6=0; sum7=0; sum8=0;
    index1=0; index2=0;index3=0;index4=0;index5=0;index6=0;index7=0;index8=0;
    total =0;
    
    for j = 1:length(data)

         if label(j) == 1
             for k = 1:length(data)
                 if label(k) == 1
                     sum1 = sum1 + norm(data(j,:) - data(k,:))^2;
                 end
             end
             index1 = index1 + 1;

         elseif label(j) == 2
             for k = 1:length(data)
                 if label(k) == 2
                     sum2 = sum2 + norm(data(j,:) - data(k,:))^2;
                 end
             end
             index2 = index2 + 1;
             
         elseif label(j) == 3
             for k = 1:length(data)
                 if label(k) == 3
                     sum3 = sum3 + norm(data(j,:) - data(k,:))^2;
                 end
             end
             index3 = index3 + 1;

         elseif label(j) == 4
             for k = 1:length(data)
                 if label(k) == 4
                     sum4= sum4 + norm(data(j,:) - data(k,:))^2;
                 end
             end
             index4 = index4 + 1;

         elseif label(j) == 5
             for k = 1:length(data)
                 if label(k) == 5
                     sum5 = sum5 + norm(data(j,:) - data(k,:))^2;
                 end
             end
             index5 = index5 + 1;

         elseif label(j) == 6
             for k = 1:length(data)
                 if label(k) == 6
                     sum6 = sum6 + norm(data(j,:) - data(k,:))^2;
                 end
             end
             index6 = index6 + 1;

         elseif label(j) == 7
             for k = 1:length(data)
                 if label(k) == 7
                     sum7 = sum7 + norm(data(j,:) - data(k,:))^2;
                 end
             end
             index7 = index7 + 1;

         else
             for k = 1:length(data)
                 if label(k) == 8
                     sum8 = sum8 + norm(data(j,:) - data(k,:))^2;
                 end
             end
             index8 = index8 + 1;
         end
    end
    
    if index1 == 0 index1 = 1; end
    if index2 == 0 index2 = 1; end
    if index3 == 0 index3 = 1; end
    if index4 == 0 index4 = 1; end
    if index5 == 0 index5 = 1; end
    if index6 == 0 index6 = 1; end
    if index7 == 0 index7 = 1; end
    if index8 == 0 index8 = 1; end

    total = (sum1/index1) + (sum2/index2) + (sum3/index3) + (sum4/index4) + (sum5/index5) + (sum6/index6) + (sum7/index7) + (sum8/index8);
    cost_value = (1/2) * total;
end
