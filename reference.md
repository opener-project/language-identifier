## Reference

### Command Line Interface

    Usage: language-identifier [options]
      -v, --version                    Shows the current version
      -k, --[no-]kaf                   Output the language as KAF
      -p, --probs                      Provide probabilities, assumes --no-kaf

#### Examples:

##### Basic Usage

    cat example_text.txt | language-identifier    # Basic detection

##### KAF is the default output

    echo "This is english text." | language-identifier    # Defaults to KAF output

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <KAF xml:lang="en" version="2.1">
        <raw>This is english text.</raw>
    </KAF>

##### Output Probabilities

    echo "This is een mix van Nederlandse and English text" | language-identifier --probs    # output probabilities            [nl:0.8579977424996601, en:0.14200189400782184]

### Webservice

You can launch a webservice by executing:

    language-identifier-server

After launching the server, you can reach the webservice at
<http://localhost:9292>.

The webservice takes several options that get passed along to [Puma](http://puma.io), the
webserver used by the component. The options are:

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

### Daemon

This component comes with a daemon that can be started using the command
`language-identifier-daemon`. By default this will start the daemon in the
foreground, by using `language-identifier-daemon start` it can be started in the
background instead.

For more information, run `language-identifier-daemon --help`.

#### Environment Variables

These daemons make use of Amazon SQS queues and other Amazon services. For these
services to work correctly you'll need to have various environment variables
set. These are as following:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_REGION`

For example:

    AWS_REGION='eu-west-1' language-identifier start [other options]

#### Daemon Options

    -h, --help                Shows this help message
    -i, --input               The name of the input queue (default: opener-language-identifier)
    -b, --bucket              The S3 bucket to store output in (default: opener-language-identifier)
    -P, --pidfile             Path to the PID file (default: /var/run/opener/opener-language-identifier-daemon.pid)
    -t, --threads             The amount of threads to use (default: 10)
    -w, --wait                The amount of seconds to wait for the daemon to start (default: 3)
        --disable-syslog      Disables Syslog logging (enabled by default)

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
