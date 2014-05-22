## Reference

### Command Line Interface

~~~~
Usage: language-identifier [options]
  -v, --version                    Shows the current version
  -k, --[no-]kaf                   Output the language as KAF
  -p, --probs                      Provide probabilities, assumes --no-kaf
~~~~

#### Examples:

##### Basic Usage

    cat example_text.txt | language-identifier    # Basic detection


##### KAF is the default output

    echo "This is english text." | language-identifier    # Defaults to KAF output

~~~~
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<KAF xml:lang="en" version="2.1">  
    <raw>This is english text.</raw>
</KAF>
~~~~

##### Output Probabilities

    echo "This is een mix van Nederlandse and English text" | language-identifier --probs    # output probabilities            [nl:0.8579977424996601, en:0.14200189400782184]

### Webservice

You can launch a webservice by executing:

    language-identifier-server


After launching the server, you can reach the webservice at
<http://localhost:9292>.

The webservice takes several options that get passed along to (Puma)[http://puma.io], the
webserver used by the component. The options are:

~~~~
-b, --bind URI                   URI to bind to (tcp://, unix://, ssl://)
-C, --config PATH                Load PATH as a config file
    --control URL                The bind url to use for the control server
                                     Use 'auto' to use temp unix server
    --control-token TOKEN        The token to use as authentication for the control server
-d, --daemon                     Daemonize the server into the background
    --debug                      Log lowlevel debugging information
    --dir DIR                    Change to DIR before starting
-e, --environment ENVIRONMENT    The environment to run the Rack app on (default development)
-I, --include PATH               Specify $LOAD_PATH directories
-p, --port PORT                  Define the TCP port to bind to
                                 Use -b for more advanced options
    --pidfile PATH               Use PATH as a pidfile
    --preload                    Preload the app. Cluster mode only
    --prune-bundler              Prune out the bundler env if possible
-q, --quiet                      Quiet down the output
-R, --restart-cmd CMD            The puma command to run during a hot restart
                                 Default: inferred
-S, --state PATH                 Where to store the state details
-t, --threads INT                min:max threads to use (default 0:16)
    --tcp-mode                   Run the app in raw TCP mode instead of HTTP mode
-V, --version                    Print the version information
-w, --workers COUNT              Activate cluster mode: How many worker processes to create
    --tag NAME                   Additional text to display in process listing
-h, --help                       Show help
~~~~


### Daemon

The daemon has the default OpeNER daemon options. Being:

    Usage: language-identifier <start|stop|restart> [options]
    When calling language-identifier without <start|stop|restart> the daemon will start as a foreground process



#### Environment Variables

These daemons make use of Amazon SQS queues and other Amazon services.
The access to these services and other environment variables can be configured
using a .opener-daemons-env file in the home directory of the current user.

It is also possible to provide the environment variables directly to the deamon.

For example:

```
AWS_REGION='eu-west-1' language-identifier start [other options]
```

We advise to have the following environment variables available: 

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* AWS_REGION

#### Daemon Options

~~~~
-i, --input QUEUE_NAME           Input queue name
-o, --output QUEUE_NAME          Output queue name
    --batch-size COUNT           Request x messages at once where x is between 1 and 10
    --buffer-size COUNT          Size of input and output buffer. Defaults to 4 * batch-size
    --sleep-interval SECONDS     The interval to sleep when the queue is empty (seconds)
-r, --readers COUNT              number of reader threads
-w, --workers COUNT              number of worker thread
-p, --writers COUNT              number of writer / pusher threads
-l, --logfile, --log FILENAME    Filename and path of logfile. Defaults to STDOUT
-P, --pidfile, --pid FILENAME    Filename and path of pidfile. Defaults to /var/run/language-identifier.pid
    --pidpath DIRNAME            Directory where to put the PID file. Is Overwritten by --pid if that option is present
    --debug                      Turn on debug log level
    --relentless                 Be relentless, fail fast, fail hard, do not continue processing when encountering component errors
~~~~


### Languages

| Code  | Language            |
| ----- | --------            |
| ar    | Arabic              |
| bg    | Bulgarian           |
| bn    | Bengali             |
| cs    | Czech               |
| da    | Danish              |
| de    | German              |
| el    | Greek               |
| en    | English             |
| es    | Spanish             |
| et    | Estonian            |
| fa    | Persian             |
| fi    | Finnish             |
| fr    | French              |
| gu    | Gujarati            |
| he    | Hebrew              |
| hi    | Hindi               |
| hr    | Croatian            |
| hu    | Hungarian           |
| id    | Indonesian          |
| it    | Italian             |
| ja    | Japanese            |
| kn    | Kannada             |
| ko    | Korean              |
| lt    | Lithuanian          |
| lv    | Latvian             |
| mk    | Macedonian          |
| ml    | Malayalam           |
| mr    | Marathi             |
| ne    | Nepali              |
| nl    | Dutch               |
| no    | Norwegian           |
| pa    | Punjabi             |
| pl    | Polish              |
| pt    | Portuguese          |
| ro    | Romanian            |
| ru    | Russian             |
| sk    | Slovak              |
| sl    | Slovene             |
| so    | Somali              |
| sq    | Albanian            |
| sv    | Swedish             |
| sw    | Swahili             |
| ta    | Tamil               |
| te    | Telugu              |
| th    | Thai                |
| tl    | Tagalog             |
| tr    | Turkish             |
| uk    | Ukrainian           |
| ur    | Urdu                |
| vi    | Vietnamese          |
| zh-cn | Simplified Chinese  |
| zh-tw | Traditional Chinese |
