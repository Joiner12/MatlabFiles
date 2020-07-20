%% ����������ṹ
classdef NNPID
    properties               %PID_NN�������
        num_neuron_1=3;      %��Ԫ����1
        num_neuron_2=0;      %��Ԫ����2
        num_neuron_3=3;      %��Ԫ����3
        W_1=[];              %Ȩ��1
        W_2=[];              %Ȩ��2
        b_1=[];              %ƫ��1
        b_2=[];              %ƫ��2
        delta_2=[];          %�ݶ�1
        delta_3=[];          %�ݶ�2
        net_2=[];            %����ڵ�ֵ1
        net_3=[];            %����ڵ�ֵ2
        eta=10;             %ѧϰ��
%         f=@(x)(tanh(x));%�����1
%         df=@(x)(4*exp(2*x))./(1+exp(4*x)+2*exp(2*x));  %������1
%         g=@(x)(logsig(x));                    %�����2
%         dg=@(x)((1./(1+exp(-x))).*(1-(1./(1+exp(-x)))));                   %������2
        trainData_x=[];      %ѵ������x
        trainData_y=[];      %ѵ������y
        batch_size=100;      %ѵ�����εĴ�С
        N_sample=0;          %ѵ�����ݵ�����
    end
    methods
        function obj=PID_NN(num)                         %���캯��
            obj.num_neuron_2=num;
        end
        function [obj]=train(obj,trainData_x,trainData_e,Iter,model)%ѵ��
            %�������Ϊ��ѵ������x��ѵ������y����ʶ������y_partial_u����������Iter��ģ��model
            %��ʼ������
            obj.num_neuron_1=size(trainData_x,2);
%             obj.num_neuron_3=size(trainData_e,2);
            obj.N_sample=size(trainData_x,1);
            obj.b_1=rand(1,obj.num_neuron_2);
            obj.b_2=rand(1,obj.num_neuron_3);
            obj.W_1=rand(obj.num_neuron_1,obj.num_neuron_2);
            obj.W_2=rand(obj.num_neuron_2,obj.num_neuron_3);
            obj.batch_size=1;
            y_partial_u=model.df(model.input(2:end))';
            %ѵ��
            for i=1:Iter
                rand_index=randperm(obj.N_sample , obj.batch_size);
                trainData_x_batch=trainData_x(rand_index,:);
                trainData_e_batch=-trainData_e(rand_index,:);
                y_partial_u_batch=y_partial_u(rand_index,:);
                [net_2_,~,net_20,net_30]=Forward_propagation(obj,trainData_x_batch);%������ǰ����
                
                
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
        
        function [obj]=train2(obj,trainData_x,trainData_y,Iter)%ѵ��
            %�������Ϊ��ѵ������x��ѵ������y����ʶ������y_partial_u����������Iter��ģ��model
            %��ʼ������
            obj.num_neuron_1=size(trainData_x,2);
            obj.num_neuron_3=size(trainData_y,2);
            obj.N_sample=size(trainData_x,1);
            obj.b_1=rand(1,obj.num_neuron_2);
            obj.b_2=rand(1,obj.num_neuron_3);
            obj.W_1=rand(obj.num_neuron_1,obj.num_neuron_2)*0.01;
            obj.W_2=rand(obj.num_neuron_2,obj.num_neuron_3)*0.01;
            obj.batch_size=obj.N_sample;
            obj.batch_size=1;
            %ѵ��
            for i=1:Iter
                rand_index=randperm(obj.N_sample , obj.batch_size);
                trainData_x_batch=trainData_x(rand_index,:);
                trainData_y_batch=trainData_y(rand_index,:);
                [net_2_,net_3_,net_20,net_30]=Forward_propagation(obj,trainData_x_batch);%������ǰ����
                
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
        function obj=output(obj,e)                       %������󱻵���
            obj.e=e;
            obj.delta_u=obj.K_P*obj.e(end) + obj.K_I*sum(obj.e,2) + ...
                obj.K_D*(obj.e(end)-obj.e(end-1));
        end
    end
end
%--------------------- %
%--------------------- %
pidnn=PID_NN(10);
%% ���ò���
trainData_x_batch=([0 0 0]);
num_thread=size(trainData_x_batch,1);%���ò���ģ����߳���
input=0;                             %ϵͳ���������
model=Model(input);                  %����ϵͳ����
pid(1:num_thread)=PID(0.1,0.7,0.003);        %����PID������
targetValue=repmat([ones(1,20) zeros(1,20)],1,20);
model(1:num_thread).targetValue=targetValue;       %����ϵͳ���Ŀ��ֵ
%% ����ѵ������
[trainData_x,trainData_y]=PID_Data(model(1),pid);
%% ѵ������
pidnn=pidnn.train(trainData_x,trainData_y,10);
%% ���� 
model_list=simulink_with_NN(pidnn,pid,model,trainData_x_batch);
%% ���ƶ�̬ͼ
close all;
figureout(model_list(1));
%--------------------- %
%--------------------- %
%% ����PID�������ṹ
classdef PID
    properties               %PID����������
%         k=10;
        e=[];        %����Ϊk���б��洢�����k����ƫ���¼
        K_P=0;               %����Ԫϵ��
        K_I=0;               %����Ԫϵ��
        K_D=0;               %΢��Ԫϵ��
        delta_u=0;
    end
    methods
        function obj=PID(K_P,K_I,K_D)   %���캯��
            obj.K_P=K_P;
            obj.K_I=K_I;
            obj.K_D=K_D;
        end
        function obj=output_1(obj,e)%������󱻵�������λ��ʽ
            obj.e=e;
            obj.delta_u=obj.K_P*obj.e(end) + obj.K_I*sum(obj.e,2) + ...
                obj.K_D*(obj.e(end)-obj.e(end-1));
        end
        function obj=output_2(obj,e)%������󱻵�����������ʽ
            obj.e=e;
            obj.delta_u=obj.K_P*(obj.e(end)-obj.e(end-1)) + ...
                obj.K_I*sum(obj.e(end)) + ...
                obj.K_D*(obj.e(end)-2*obj.e(end-1)+obj.e(end-2));
        end
    end
end
%--------------------- %
%--------------------- %
%% ����ģ��
classdef Model
    properties               %ϵͳģ�Ͳ���
        input=0;             %ģ������
        output=0;            %ģ�����
        e_list=[];           %ģ�����
        K_list=[];
        targetValue=0;
        f=@(x)(x);        %ģ�ͺ���
        df=@(x)(1+x*0);
    end
    methods
        function obj=Model(input)   %���캯��
            obj.input=input;
            obj.output=obj.f(input);
        end
        function obj=step(obj,input)%�����������
            obj.input=[obj.input input];
            obj.output=[obj.output obj.f(input)];
        end
        function obj=target(obj,targetValue)%�����������
            obj.targetValue=targetValue;
        end
    end
end
%--------------------- %
%--------------------- %

function [model,trainData_x,trainData_y]=simulink_with_NN(obj,pid,model,trainData_x_batch)
%% PID���ƹ���
num_thread=size(trainData_x_batch,1);%���ò���ģ����߳���
% k=3;                                 %����
e=trainData_x_batch;                 %���
size(model(1).targetValue,2)
for j=1:size(model(1).targetValue,2)
    for i=1:num_thread               %���ζ�ÿ���߳̽��м���
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
%% �����ϵͳ�������е�ѵ������
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

%% ΪPID_NN�ṩϵͳ�����ѵ�����ݺͱ�ʶ�������������ѵ��
function [model,trainData_x,trainData_y]=PID_Data(model,pid)
% tic
%% PID���ƹ���
k=5;%����
e=zeros(1,k);%���
for i=1:size(model.targetValue,2)
    e0=model.targetValue(i)-model.output(end);
    model.e_list=[model.e_list e0];
    e=[e(2:end) e0];
    pid=pid.output_2(e);
    input0=model.input(end);% + pid.delta_u(end);
    model=model.step(input0);
end
toc
%% �����ϵͳ�������е�ѵ������
x1=model.e_list(3:end);
x2=model.e_list(3:end)-model.e_list(2:end-1);
x3=model.e_list(3:end)-2*model.e_list(2:end-1)+model.e_list(1:end-2);
trainData_x=[x1' x2' x3'];
trainData_y=x1';
trainData_x(end,:)=[];
trainData_y(1,:)=[];
%% ������ʶ������
% [y_partial_u]=Identifier(model.df,model.input(3:end-1));
end
%--------------------- %
%--------------------- %

%% ���嶯̬ͼչʾ����
function figureout(model)
figure;
%����ͼ�񱳾�
colordef white;
set(gcf,'Units','normalized','Position',[0 0 1 1]);
for i=1:size(model.input,2)-1
%     plot(1:i,model.output(i:-1:1),'b-')
    plot([1:i;1:i]',[model.output(i:-1:1);model.targetValue(i:-1:1)]')
    %�����켣�ϵĵ�
    line('xdata',1,'ydata',model.output(:,i),'Color','b','Marker','.','MarkerSize',40);
    filed_y=[min(model.output) max(model.output) max(model.output)-min(model.output)];
    axis([0,size(model.input,2),filed_y(1)-0.15*filed_y(3),filed_y(2)+0.15*filed_y(3)]);
    drawnow;
end
legend('ʵ��ֵ','Ŀ��ֵ')
end
