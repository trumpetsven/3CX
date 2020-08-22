# What is it
This Script is for polling the currently active interal and external telephone calls on a 3CX PBX https://www.3cx.com with PRTG Network Monitor https://www.paessler.com/prtg

![Screenshot](/screenshot.png)

# Installation

* Install perl on your PRTG probe (for Windows I used http://strawberryperl.com/ portable edition)
* Your perl installation needs to have the REST::Client module installed (https://metacpan.org/pod/REST::Client). For Strawberry perl you need to 
  * run `portableshell.bat`
  * type `perl -MCPAN -e shell`
  * and on the CPAN Prompt `install REST::Client`
* Copy the batch (poll3cx.bat) and perl script (poll3cx.pl) to `c:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\`
* Create a new XML REST Sensor https://www.paessler.com/manuals/prtg/http_xmlrest_value_sensor and point to the batch

# Verification
If you run the batch, the output should be:

    C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML>poll3cx.bat
    { "prtg": { "result": [ { "channel": "calls_internal", "value": "0" }, { "channel": "calls_external", "value": "1" }, { "channel": "sum", "value": "1" } ] } }

# Debugging
Remove the comment sign on each line starting with `# print` and run the batch.
