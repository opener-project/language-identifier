package org.vicomtech.opennlp.LanguageDetection;

import java.io.IOException;
import java.util.ArrayList;

import com.cybozu.labs.langdetect.Detector;
import com.cybozu.labs.langdetect.DetectorFactory;
import com.cybozu.labs.langdetect.LangDetectException;
import com.cybozu.labs.langdetect.Language;

/**
 * This class is a wrapper for the Cybozu'Labs language detection 
 * library
 * 
 * @author Andoni Azpeitia
 *
 */
public class CybozuDetector {
	
	/**
	 * Public constructor, load the language profiles from inside 
	 * the application
	 * @throws LangDetectException
	 * @throws IOException
	 */
	public CybozuDetector () throws LangDetectException, IOException {
		DetectorFactory.loadProfile();
	}
	
	/**
	 * Public constructor, loads the specified language profiles
	 * directory
	 * @param profileDirectory
	 * @throws LangDetectException
	 */
	public CybozuDetector (String profileDirectory) throws LangDetectException {
		DetectorFactory.loadProfile(profileDirectory);
	}
	
	/**
	 * Detect the language of the input text
	 * @param text : input text
	 * @return
	 * @throws LangDetectException
	 */
    public String detect(String text) throws LangDetectException {
        Detector detector = DetectorFactory.create();
        detector.append(text);
        return detector.detect();
    }
    
    /**
     * Returns the probabilities of the detected languages
     * @param text : input text
     * @return
     * @throws LangDetectException
     */
    public ArrayList<Language> detectLangs(String text) throws LangDetectException {
        Detector detector = DetectorFactory.create();
        detector.append(text);
        return detector.getProbabilities();
    }

}
