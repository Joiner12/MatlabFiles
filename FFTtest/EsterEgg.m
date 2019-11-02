
figure(1);%���庯��
axis([-5.1,5,-0.05,1.05]);%���ƶ�άͼ��
hold on;%���ֵ�ǰͼ�μ���ϵ���е�����
axis('off');%��������̶ȣ�����䱳��
%ͨ�������̨�׼����ߵĵ���
fill([-5.1,-5,-5,-5.1],[-0.05,-0.05,1.05,1.05],[0,0.5,0]);
fill([4.12,4.22,4.22,4.12],[-0.05,-0.05,1.05,1.05],[0,0.5,0]);
fill([-5,-3.2,-3.2,-5],[-0.05,-0.05,0,0],[0,0.5,0]);
fill([-3.2,-2.8,-2.8,-3.2],[-0.05,-0.05,0.2,0.2],[0,0.5,0]);
fill([-3.2,-1.4,-1.4,-3.2],[0.2,0.2,0.25,0.25],[0,0.5,0]);
fill([-1.4,-1,-1,-1.4],[0.2,0.2,0.45,0.45],[0,0.5,0]);
fill([-1.4,0.4,0.4,-1.4],[0.45,0.45,0.5,0.5],[0,0.5,0]);
fill([0.4,0.8,0.8,0.4],[0.45,0.45,0.7,0.7],[0,0.5,0]);
fill([0.4,2.0,2.0,0.4],[0.7,0.7,0.75,0.75],[0,0.5,0]);
fill([2.0,2.3,2.3,2.0],[-0.05,-0.05,0.75,0.75],[0,0.5,0]);
fill([2.3,4.12,4.12,2.3],[-0.05,-0.05,0,0],[0,0.5,0]);
%x1=line([-5,5],[0,0],'color','g','linestyle','-', 'markersize',50)%����̨�ױ߿��ߣ���ɫ�����Է�ʽ
%x2=line([-5,5],[0.25,0.25],'color','g','linestyle','-', 'markersize',50)%����̨�ױ߿��ߣ���ɫ�����Է�ʽ
%line([-5,5],[0.5,0.5],'color','b','linestyle','-', 'markersize',50)%�����������Ӵ������ɫ�����Է�ʽ
%line([-5,5],[0.75,0.75],'color','b','linestyle','-', 'markersize',50)%�����������Ӵ������ɫ�����Է�ʽ
head=line(-5,1,'color','r','linestyle','.','erasemode','xor', 'markersize');%����С����ɫ����С�������Ͳ��Է�ʽ
%body=line(-5,1,'color','b','linestyle','-','erasemode','none'); %���켣��
%���ó�ʼ����
t=-5;
dt=0.001;
w=0;
dw=0.001;
while 1 %������������һ̨�׵ķ�Χ�͸߶�
    while t<=-4
        t=dt+t;
        if w<=1
            w=dw+w;
        else
            w=-1;
        end
        y=-w*w+1;
        set(head,'xdata',t,'ydata',y);%��������˶�
        %set(body,'xdata',t,'ydata',y);%���켣��
        drawnow;
    end %��������
    w=-1;%��������ĳ�ʼλ��
    %�����������ڶ�̨�׵ķ�Χ�͸߶�
    while t<=-2.31
        t=dt+t;
        if w<=1
            w=dw+w;
        else
            w=-1;
        end
        y=(-w*w)/2+0.5;
        set(head,'xdata',t,'ydata',y);%��������˶�
        %set(body,'xdata',t,'ydata',y);%���켣��
        drawnow;
    end %��������
    w=-1;%��������ĳ�ʼλ��
    %��������������̨�׵ķ�Χ�͸߶�
    while t<=-0.62
        t=dt+t;
        if w<=1
            w=dw+w;
        else
            w=-1;
        end
        y=(-w*w)/2+0.75;
        set(head,'xdata',t,'ydata',y);%��������˶�
        %set(body,'xdata',t,'ydata',y);%���켣��
        drawnow;
    end %��������
    w=-1;%��������ĳ�ʼλ��
    %��������������̨�׵ķ�Χ�͸߶�
    while t<=1.1
        t=dt+t;
        if w<=1
            w=dw+w;
        else
            w=-1;
        end
        y=(-w*w)/2+1;
        set(head,'xdata',t,'ydata',y);%��������˶�
        %set(body,'xdata',t,'ydata',y);%���켣��
        drawnow;
    end %��������
    w=-1;%��������ĳ�ʼλ��
    %��������������̨�׵ķ�Χ�͸߶�
    while t<=2.11
        t=dt+t;
        if w<=1
            w=dw+w;
        else
            w=-1;
        end
        y=(-w*w)/4+1;
        set(head,'xdata',t,'ydata',y);%��������˶�
        %set(body,'xdata',t,'ydata',y);%���켣��
        drawnow;
    end %��������
    w=0;%��������ĳ�ʼλ��
    %��������ĸ߶�
    while t<=4.12
        t=dt+t;
        if w<=1
            w=dw+w;
        else
            w=-1;
        end
        y=(-w*w)+1;
        set(head,'xdata',t,'ydata',y);%��������˶�
        %set(body,'xdata',t,'ydata',y);%���켣��
        drawnow;
    end %��������
    w=0;%��������ĳ�ʼλ��
    %��������ĸ߶�
    while t>=2.11
        t=t-dt;
        if w<=1
            w=dw+w;
        else
            w=-1;
        end
        y=(-w*w)+1;
        set(head,'xdata',t,'ydata',y);%��������˶�
        %set(body,'xdata',t,'ydata',y);%���켣��
        drawnow;
    end %��������
    w=0;%��������ĳ�ʼλ��
    %��������ĸ߶�
    while t>=1.11
        t=t-dt;
        if w<=1
            w=dw+w;
        else
            w=-1;
        end
        y=(-w*w)/4+1;
        set(head,'xdata',t,'ydata',y);%��������˶�
        %set(body,'xdata',t,'ydata',y);%���켣��
        drawnow;
    end %��������
    w=-0.71;%��������ĳ�ʼλ��
    %��������ĸ߶�
    while t>=-0.62
        t=t-dt;
        if w<=1
            w=dw+w;
        else
            w=-1;
        end
        y=(-w*w)/2+1;
        set(head,'xdata',t,'ydata',y);%��������˶�
        %set(body,'xdata',t,'ydata',y);%���켣��
        drawnow;
    end %��������
    w=-0.71;%��������ĳ�ʼλ��
    %��������ĸ߶�
    while t>=-2.31
        t=t-dt;
        if w<=1
            w=dw+w;
        else
            w=-1;
        end
        y=(-w*w)/2+0.75;
        set(head,'xdata',t,'ydata',y);%��������˶�
        %set(body,'xdata',t,'ydata',y);%���켣��
        drawnow;
    end %��������
    w=-0.71;%��������ĳ�ʼλ��
    %��������ĸ߶�
    while t>=-4
        t=t-dt;
        if w<=1
            w=dw+w;
        else
            w=-1;
        end
        y=(-w*w)/2+0.5;
        set(head,'xdata',t,'ydata',y);%��������˶�
        %set(body,'xdata',t,'ydata',y);%���켣��
        drawnow;
    end %��������
    w=-1;%��������ĳ�ʼλ��
    %��������ĸ߶�
    while t>=-5
        t=t-dt;
        if w<=1
            w=dw+w;
        else
            w=-1;
        end
        y=(-w*w)+1;
        set(head,'xdata',t,'ydata',y);%��������˶�
        %set(body,'xdata',t,'ydata',y);%���켣��
        drawnow;
    end %��������
end

