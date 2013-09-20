package org.vicomtech.opennlp.LanguageDetection;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

import com.cybozu.labs.langdetect.LangDetectException;
import com.cybozu.labs.langdetect.Language;

/**
 * This class detects the language of the input text read from
 * standard input. 
 * You can also get the probabilities of the languages detected.
 * To implement this functionalities the application uses the
 * Cybozu'Labs language detection library:
 * http://code.google.com/p/language-detection/
 * 
 * @author Andoni Azpeitia
 *
 */
public class Main {
	
	private boolean probs = false;
	private String profileDirectory = null;
	
	/**
	 * Get arguments for the application
	 * @param args
	 */
	private void getArguments(String[] args) {
		
		for (int i=0; i<args.length; i++) {
			String arg = args[i];
			// help option
			if (arg.equalsIgnoreCase("--help")
					|| arg.equalsIgnoreCase("-help")
					|| arg.equalsIgnoreCase("-h"))
				this.showHelp();
			// probs option
			else if (arg.equalsIgnoreCase("-probs")) {
				this.probs = true;
			}
			// custom profile dir option
			else if (arg.equalsIgnoreCase("-profileDir")) {
				if (i<args.length-1 && !args[i+1].startsWith("-"))
					this.profileDirectory = args[i+1];
				else
					this.showHelp();
			}
		}
	}
	
	/**
	 * Main method, reads text from standard input
	 * @param args
	 */
	public static void main( String[] args ) {

    	Main main = new Main();
    	main.getArguments(args);
    	
    	try {
    		String text = main.read();
    		
    		if (!main.probs)
    			System.out.println(main.detect(text));
    		else
    			main.probs(text);
    		
		} catch (IOException e) {
			e.printStackTrace();
		} catch (LangDetectException e) {
			e.printStackTrace();
		}
    }
	
	/**
	 * Reads from standard input and returns the text
	 * @return
	 * @throws IOException
	 */
	private String read() throws IOException {
		
		// read text from standard input
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		String line = null;
		String text = new String();
		while ((line = br.readLine()) != null) {
			text+=line+"\n";
		}
		br.close();
		
		// return text
		return text;
	}
	
	/**
	 * Detects the language of the text
	 * @param text : input text
	 * @return detected language
	 * @throws IOException
	 * @throws LangDetectException
	 */
	private String detect(String text) throws IOException, LangDetectException {
		
		// create object
		CybozuDetector detector;
		if (this.profileDirectory == null)
			detector = new CybozuDetector();
		else
			detector = new CybozuDetector(this.profileDirectory);
		
		// detect language
		return detector.detect(text);
	}
	
	/**
	 * Prints the languages detected and its probabilities
	 * @param text : input text
	 * @throws LangDetectException
	 * @throws IOException
	 */
    private void probs(String text) throws LangDetectException, IOException {
    	
    	// create object
    	CybozuDetector detector;
    	if (this.profileDirectory == null)
    		detector = new CybozuDetector();
    	else
    		detector = new CybozuDetector(this.profileDirectory);
    	
    	// detect probs
    	List<Language> probs = detector.detectLangs(text);
    	for (Language lang : probs) {
    		System.out.println("Language: "+lang.lang+"\t" +
    				"Probability: "+lang.prob);
    	}
    }
	
    /**
     * Prints the application usage
     */
    private void showHelp() {
		System.out.println("Usage: language-identifier [options]");
		System.out.println("  -h, --help                       Shows this help message");
		System.out.println("  -probs                           Shows probability for each language");
		System.out.println("  -profileDir path                 Use custom language profiles");
		System.out.println();
		System.out.println("Examples:");
		System.out.println();
		System.out.println("  cat example_text.txt | java -jar LanguageDetection-0.0.1.jar -profileDir path");
		System.out.println("  cat example_text.txt | java -jar LanguageDetection-0.0.1.jar -probs");
		System.out.println("  echo 'this is some Englis text' | java -jar LanguageDetection-0.0.1.jar");
		System.exit(0);
	}
    
}
