Replicated Helm Starter
-----------------------

Use this starter with `helm create` to create a chart that's ready for
distribution with the Replicated platform.

Note
----

Pending approval of helm/helm#11273, you have to make a couple of additional
changes after your run `helm create`:

1. Copy the file `Chart.yaml` from the starter source to your chart.
2. Replaced the strong `<CHARTNAME>` in the new `Chart.yaml` file with the
   name of your chart.
