%% 定义神经网络结构
classdef NNPID
    properties               %PID_NN网络参数
        num_neuron_1=3;      %神经元个数1
        num_neuron_2=0;      %神经元个数2
        num_neuron_3=3;      %神经元个数3
        W_1=[];              %权重1
        W_2=[];              %权重2
        b_1=[];              %偏置1
        b_2=[];              %偏置2
        delta_2=[];          %梯度1
        delta_3=[];          %梯度2
        net_2=[];            %网络节点值1
        net_3=[];            %网络节点值2
        eta=10;             %学习率
%         f=@(x)(tanh(x));%激活函数1
%         df=@(x)(4*exp(2*x))./(1+exp(4*x)+2*exp(2*x));  %导函数1
%         g=@(x)(logsig(x));                    %激活函数2
%         dg=@(x)((1./(1+exp(-x))).*(1-(1./(1+exp(-x)))));                   %导函数2
        trainData_x=[];      %训练数据x
        trainData_y=[];      %训练数据y
        batch_size=100;      %训练批次的大小
        N_sample=0;          %训练数据的总量
    end
    methods
        function obj=PID_NN(num)                         %构造函数
            obj.num_neuron_2=num;
        end
        function [obj]=train(obj,trainData_x,trainData_e,Iter,model)%训练
            %输入参数为，训练数据x，训练数据y，辨识器数据y_partial_u，迭代次数Iter，模型model
            %初始化参数
            obj.num_neuron_1=size(trainData_x,2);
%             obj.num_neuron_3=size(trainData_e,2);
            obj.N_sample=size(trainData_x,1);
            obj.b_1=rand(1,obj.num_neuron_2);
            obj.b_2=rand(1,obj.num_neuron_3);
            obj.W_1=rand(obj.num_neuron_1,obj.num_neuron_2);
            obj.W_2=rand(obj.num_neuron_2,obj.num_neuron_3);
            obj.batch_size=1;
            y_partial_u=model.df(model.input(2:end))';
            %训练
            for i=1:Iter
                rand_index=randperm(obj.N_sample , obj.batch_size);
                trainData_x_batch=trainData_x(rand_index,:);
                trainData_e_batch=-trainData_e(rand_index,:);
                y_partial_u_batch=y_partial_u(rand_index,:);
                [net_2_,~,net_20,net_30]=Forward_propagation(obj,trainData_x_batch);%计算向前传播
                
                
                delta_3_=repmat(trainData_e_batch.*y_partial_u_batch,1,obj.num_neuron_3).*dg(net_30).*trainData_x_batch;
                delta_w_3=obj.eta*net_2_'*delta_3_;
                delta_2_=df(net_20).*repmat((sum(delta_3_,1)*obj.W_2'),obj.batch_size,1);
                delta_w_2=obj.eta*trainData_x_batch'*delta_2_;
                
                obj.W_1=obj.W_1-delta_w_2;
                obj.W_2=obj.W_2-delta_w_3;
                obj.b_1=obj.b_1-obj.eta*sum(delta_2_,1);
                obj.b_2=obj.b_2-obj.eta*sum(delta_3_,1);
%                 disp(sum(delta_3_,1))
            end
            obj.delta_2=delta_2_;
            obj.delta_3=delta_3_;
        end
        
        function [obj]=train2(obj,trainData_x,trainData_y,Iter)%训练
            %输入参数为，训练数据x，训练数据y，辨识器数据y_partial_u，迭代次数Iter，模型model
            %初始化参数
            obj.num_neuron_1=size(trainData_x,2);
            obj.num_neuron_3=size(trainData_y,2);
            obj.N_sample=size(trainData_x,1);
            obj.b_1=rand(1,obj.num_neuron_2);
            obj.b_2=rand(1,obj.num_neuron_3);
            obj.W_1=rand(obj.num_neuron_1,obj.num_neuron_2)*0.01;
            obj.W_2=rand(obj.num_neuron_2,obj.num_neuron_3)*0.01;
            obj.batch_size=obj.N_sample;
            obj.batch_size=1;
            %训练
            for i=1:Iter
                rand_index=randperm(obj.N_sample , obj.batch_size);
                trainData_x_batch=trainData_x(rand_index,:);
                trainData_y_batch=trainData_y(rand_index,:);
                [net_2_,net_3_,net_20,net_30]=Forward_propagation(obj,trainData_x_batch);%计算向前传播
                
                trainData_e_batch=net_3_-trainData_y_batch;
%                 net_30
%                 dg(net_30)
                delta_3_=trainData_e_batch.*dg(net_30);
                delta_w_3=obj.eta*net_2_'*delta_3_;
%                 net_20
%                 df(net_20)
                delta_2_=df(net_20).*repmat((sum(delta_3_,1)*obj.W_2'),obj.batch_size,1);
                delta_w_2=obj.eta*trainData_x_batch'*delta_2_;
                
                obj.W_1=obj.W_1-delta_w_2;
                obj.W_2=obj.W_2-delta_w_3;
                obj.b_1=obj.b_1-obj.eta*sum(delta_2_,1);
                obj.b_2=obj.b_2-obj.eta*sum(delta_3_,1);
            end
            obj.delta_2=delta_2_;
            obj.delta_3=delta_3_;
        end
        
        function [net_2,net_3,net_20,net_30]=Forward_propagation(obj,trainData_x_batch)
            net_20=trainData_x_batch*obj.W_1+obj.b_1;
            net_2=tanh(net_20);
            net_30=net_2*obj.W_2+obj.b_2;
            net_3=logsig(net_30);
        end
        %--------------------------
        function obj=output(obj,e)                       %输出对象被调量
            obj.e=e;
            obj.delta_u=obj.K_P*obj.e(end) + obj.K_I*sum(obj.e,2) + ...
                obj.K_D*(obj.e(end)-obj.e(end-1));
        end
    end
end
%--------------------- %
%--------------------- %
pidnn=PID_NN(10);
%% 设置参数
trainData_x_batch=([0 0 0]);
num_thread=size(trainData_x_batch,1);%设置并行模拟的线程数
input=0;                             %系统对象的输入
model=Model(input);                  %创建系统对象
pid(1:num_thread)=PID(0.1,0.7,0.003);        %创建PID控制器
targetValue=repmat([ones(1,20) zeros(1,20)],1,20);
model(1:num_thread).targetValue=targetValue;       %设置系统输出目标值
%% 产生训练数据
[trainData_x,trainData_y]=PID_Data(model(1),pid);
%% 训练网络
pidnn=pidnn.train(trainData_x,trainData_y,10);
%% 仿真 
model_list=simulink_with_NN(pidnn,pid,model,trainData_x_batch);
%% 绘制动态图
close all;
figureout(model_list(1));
%--------------------- %
%--------------------- %
%% 定义PID控制器结构
classdef PID
    properties               %PID控制器参数
%         k=10;
        e=[];        %长度为k的列表，存储了最近k步的偏差记录
        K_P=0;               %比例元系数
        K_I=0;               %积分元系数
        K_D=0;               %微分元系数
        delta_u=0;
    end
    methods
        function obj=PID(K_P,K_I,K_D)   %构造函数
            obj.K_P=K_P;
            obj.K_I=K_I;
            obj.K_D=K_D;
        end
        function obj=output_1(obj,e)%输出对象被调量——位置式
            obj.e=e;
            obj.delta_u=obj.K_P*obj.e(end) + obj.K_I*sum(obj.e,2) + ...
                obj.K_D*(obj.e(end)-obj.e(end-1));
        end
        function obj=output_2(obj,e)%输出对象被调量——增量式
            obj.e=e;
            obj.delta_u=obj.K_P*(obj.e(end)-obj.e(end-1)) + ...
                obj.K_I*sum(obj.e(end)) + ...
                obj.K_D*(obj.e(end)-2*obj.e(end-1)+obj.e(end-2));
        end
    end
end
%--------------------- %
%--------------------- %
%% 定义模型
classdef Model
    properties               %系统模型参数
        input=0;             %模型输入
        output=0;            %模型输出
        e_list=[];           %模型误差
        K_list=[];
        targetValue=0;
        f=@(x)(x);        %模型函数
        df=@(x)(1+x*0);
    end
    methods
        function obj=Model(input)   %构造函数
            obj.input=input;
            obj.output=obj.f(input);
        end
        function obj=step(obj,input)%步进输出函数
            obj.input=[obj.input input];
            obj.output=[obj.output obj.f(input)];
        end
        function obj=target(obj,targetValue)%步进输出函数
            obj.targetValue=targetValue;
        end
    end
end
%--------------------- %
%--------------------- %

function [model,trainData_x,trainData_y]=simulink_with_NN(obj,pid,model,trainData_x_batch)
%% PID控制过程
num_thread=size(trainData_x_batch,1);%设置并行模拟的线程数
% k=3;                                 %误差长度
e=trainData_x_batch;                 %误差
size(model(1).targetValue,2)
for j=1:size(model(1).targetValue,2)
    for i=1:num_thread               %依次对每个线程进行计算
        [~,net_3]=Forward_propagation(obj,e);
        model.K_list=[model.K_list;net_3];
        pid(i).K_P=net_3(i,1)*0.05;
        pid(i).K_I=net_3(i,2)*0.05;
        pid(i).K_D=net_3(i,3)*0.05;
%         pid(i).K_P=0.1;
%         pid(i).K_D=0.005;
        e0=model(i).targetValue(j)-model(i).output(end);
        model(i).e_list=[model(i).e_list e0];
        e=[e(2:end) e0];
        pid(i)=pid(i).output_2(e);
        input0=model(i).input(end) + pid(i).delta_u(end);
        model(i)=model(i).step(input0);
    end
end
%% 整理出系统对象运行的训练数据
x1=model.e_list(3:end);
x2=model.e_list(3:end)-model.e_list(2:end-1);
x3=model.e_list(3:end)-2*model.e_list(2:end-1)+model.e_list(1:end-2);
trainData_x=[x1' x2' x3'];
trainData_y=x1';
trainData_x(end,:)=[];
trainData_y(1,:)=[];
end
%--------------------- %
%--------------------- %

%% 为PID_NN提供系统对象的训练数据和辨识器输出——离线训练
function [model,trainData_x,trainData_y]=PID_Data(model,pid)
% tic
%% PID控制过程
k=5;%误差长度
e=zeros(1,k);%误差
for i=1:size(model.targetValue,2)
    e0=model.targetValue(i)-model.output(end);
    model.e_list=[model.e_list e0];
    e=[e(2:end) e0];
    pid=pid.output_2(e);
    input0=model.input(end);% + pid.delta_u(end);
    model=model.step(input0);
end
toc
%% 整理出系统对象运行的训练数据
x1=model.e_list(3:end);
x2=model.e_list(3:end)-model.e_list(2:end-1);
x3=model.e_list(3:end)-2*model.e_list(2:end-1)+model.e_list(1:end-2);
trainData_x=[x1' x2' x3'];
trainData_y=x1';
trainData_x(end,:)=[];
trainData_y(1,:)=[];
%% 给出辨识器数据
% [y_partial_u]=Identifier(model.df,model.input(3:end-1));
end
%--------------------- %
%--------------------- %

%% 定义动态图展示函数
function figureout(model)
figure;
%设置图像背景
colordef white;
set(gcf,'Units','normalized','Position',[0 0 1 1]);
for i=1:size(model.input,2)-1
%     plot(1:i,model.output(i:-1:1),'b-')
    plot([1:i;1:i]',[model.output(i:-1:1);model.targetValue(i:-1:1)]')
    %画出轨迹上的点
    line('xdata',1,'ydata',model.output(:,i),'Color','b','Marker','.','MarkerSize',40);
    filed_y=[min(model.output) max(model.output) max(model.output)-min(model.output)];
    axis([0,size(model.input,2),filed_y(1)-0.15*filed_y(3),filed_y(2)+0.15*filed_y(3)]);
    drawnow;
end
legend('实际值','目标值')
end
