<pre><font color="#8AE234">orybachok</font>@maximus-pc-linux <font color="#4E9A06">~/D/C/P/H/t/hw-web-app</font>&gt; <font color="#005FD7">timoni</font> <font color="#00AFFF">apply</font> <font color="#00AFFF">test</font> <font color="#00AFFF"><u style="text-decoration-style:solid">.</u></font> <font color="#00AFFF">--values</font> <font color="#00AFFF"><u style="text-decoration-style:solid">values.yaml</u></font>
<font color="#555753">11:57PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <b>building .</b>
<font color="#555753">11:57PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <b>using module timoni.sh/hw-web-app version 0.0.0-devel</b>
<font color="#555753">11:57PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <b>installing </b><font color="#06989A"><b>test</b></font> in namespace <font color="#06989A">default</font>
<font color="#555753">11:57PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <font color="#06989A"><b>ServiceAccount/default/test</b></font> <font color="#8AE234">created</font>
<font color="#555753">11:57PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <font color="#06989A"><b>ConfigMap/default/test-a7cd7459</b></font> <font color="#8AE234">created</font>
<font color="#555753">11:57PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <font color="#06989A"><b>Service/default/test</b></font> <font color="#8AE234">created</font>
<font color="#555753">11:57PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <font color="#06989A"><b>Deployment/default/test</b></font> <font color="#8AE234">created</font>
<font color="#555753">11:57PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <b>resources are ready</b>
<font color="#8AE234">orybachok</font>@maximus-pc-linux <font color="#4E9A06">~/D/C/P/H/t/hw-web-app</font>&gt; <font color="#005FD7">kubectl</font> <font color="#00AFFF">get</font> <font color="#00AFFF">po</font>
NAME                   READY   STATUS    RESTARTS   AGE
test-c547c9865-jxjpt   1/1     Running   0          9s
test-c547c9865-tcmth   1/1     Running   0          9s
<font color="#8AE234">orybachok</font>@maximus-pc-linux <font color="#4E9A06">~/D/C/P/H/t/hw-web-app</font>&gt; <font color="#005FD7">kubectl</font> <font color="#00AFFF">get</font> <font color="#00AFFF">svc</font>
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1      &lt;none&gt;        443/TCP   6m21s
test         ClusterIP   10.96.84.114   &lt;none&gt;        80/TCP    12s
<font color="#8AE234">orybachok</font>@maximus-pc-linux <font color="#4E9A06">~/D/C/P/H/t/hw-web-app</font>&gt; <font color="#005FD7">kubectl</font> <font color="#00AFFF">get</font> <font color="#00AFFF">cm</font>
NAME               DATA   AGE
kube-root-ca.crt   1      6m16s
test-a7cd7459      2      14s
<font color="#8AE234">orybachok</font>@maximus-pc-linux <font color="#4E9A06">~/D/C/P/H/t/hw-web-app</font>&gt; <font color="#005FD7">kubectl</font> <font color="#00AFFF">get</font> <font color="#00AFFF">all</font>
NAME                       READY   STATUS    RESTARTS   AGE
pod/test-c547c9865-jxjpt   1/1     Running   0          21s
pod/test-c547c9865-tcmth   1/1     Running   0          21s

NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1      &lt;none&gt;        443/TCP   6m30s
service/test         ClusterIP   10.96.84.114   &lt;none&gt;        80/TCP    21s

NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/test   2/2     2            2           21s

NAME                             DESIRED   CURRENT   READY   AGE
replicaset.apps/test-c547c9865   2         2         2       21s
<font color="#8AE234">orybachok</font>@maximus-pc-linux <font color="#4E9A06">~/D/C/P/H/t/hw-web-app</font>&gt; <font color="#005FD7">timoni</font> <font color="#00AFFF">list</font>
NAME	MODULE	VERSION    	LAST APPLIED        	BUNDLE 
test	.     	0.0.0-devel	2025-03-30T20:57:55Z	-     	
<font color="#8AE234">orybachok</font>@maximus-pc-linux <font color="#4E9A06">~/D/C/P/H/t/hw-web-app</font>&gt; <font color="#005FD7">timoni</font> <font color="#00AFFF">status</font> <font color="#00AFFF">test</font>
<font color="#555753">11:58PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <b>last applied </b><font color="#06989A"><b>2025-03-30T20:57:55Z</b></font>
<font color="#555753">11:58PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <b>module </b><font color="#06989A"><b>.:0.0.0-devel</b></font>
<font color="#555753">11:58PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <b>digest </b><font color="#06989A"><b>unknown</b></font>
<font color="#555753">11:58PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <b>container image </b><font color="#06989A"><b>nginx:latest</b></font>
<font color="#555753">11:58PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <font color="#06989A"><b>ServiceAccount/default/test</b></font> <font color="#8AE234">Current</font> - Resource is current
<font color="#555753">11:58PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <font color="#06989A"><b>ConfigMap/default/test-a7cd7459</b></font> <font color="#8AE234">Current</font> - Resource is always ready
<font color="#555753">11:58PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <font color="#06989A"><b>Service/default/test</b></font> <font color="#8AE234">Current</font> - Service is ready
<font color="#555753">11:58PM</font> <font color="#4E9A06">INF</font> <font color="#555753"><b>i:</b></font><font color="#AD7FA8">test</font><font color="#06989A"> &gt;</font> <font color="#06989A"><b>Deployment/default/test</b></font> <font color="#8AE234">Current</font> - Deployment is available. Replicas: 2</pre>