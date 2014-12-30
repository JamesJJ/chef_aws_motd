chef_aws_motd
=============

This cookbook can create a static MOTD file or a script version.

* All of the attributes instance-identity/document attributes are
available to use in a template.
http://169.254.169.254/latest/dynamic/instance-identity/document:
```
{
  "instanceId" : "i-xxxxxxxx",
  "billingProducts" : null,
  "imageId" : "ami-xxxxxxxx",
  "architecture" : "x86_64",
  "pendingTime" : "2015-01-01T01:01:01Z",
  "instanceType" : "c3.8xlarge",
  "accountId" : "000000000000",
  "kernelId" : "aki-xxxxxxxx",
  "ramdiskId" : null,
  "region" : "tw-north-1",
  "version" : "2015-01-01",
  "availabilityZone" : "tw-north-1a",
  "privateIp" : "10.11.12.13",
  "devpayProductCodes" : null
}
```

* This cookbook intentionally does not require any AWS credentials
or IAM permissions - It just uses the basic information available
to an instance

* The cookbook supports applying simple transform maps to any AWS
attribute e.g. to convert AWS account numbers to friendly names:
```
node['aws_motd']['map'] = 
    [ "accountId" => [ "11111111" => "DEV", "22222222" => "PROD" ]
```

* This cookbook should also work on a non-AWS instance, just none
of the AWS attributes will be available.

"It works for me" - If it doesn't work for you: fork it, change it, test it, submit pull request ;)


