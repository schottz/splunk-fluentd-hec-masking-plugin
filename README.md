# Splunk Fluentd HEC with Masking Plugin

This image is aimed to supply a very specific solution, when you need to integrate splunk with your kubernetes cluster.

This image take advantage on **[Splunk's Fluent Plugin HEC](https://github.com/splunk/fluent-plugin-splunk-hec)**, adding the **[Fluent Plugin Masking](https://github.com/payu/fluent-plugin-masking)** plugin for the compliance purpose of hiding certain information inside logs.

That's the way I found when you use **[Splunk's Fluent Plugin HEC](https://github.com/splunk/fluent-plugin-splunk-hec)** and need to add some extra features to it.

## How it works

The way it is structured, you just have to create your container having a environment variable called **`HIDDEN_FIELDS`** and put the fields names separated by comma.

The `entrypoint.sh` will put each field name to a file `/opt/fields-to-hide.txt`

After that, just configure your **[Fluent Plugin Masking](https://github.com/payu/fluent-plugin-masking)** plugin to get the fields names from there. In order to do that, you add the code below to the configmap that sets your container.

	<filter "**">
	@type masking
	fieldsToMaskFilePath "/opt/fields-to-hide.txt"
	</filter>

## Build

The `build.sh` contains an example of how you can build this image on a multi platform perspective. I had to use this, since I'm on an ARM architecture and had to build for AMD.

Remember of changing the image name to point to your own repository.

Have Fun!