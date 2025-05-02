import java.util.*;
import java.util.regex.*;

public class ResumeAnalyzer {

    // Extract skills from text using regex
    public static Set<String> extractSkills(String text) {
        Set<String> skills = new HashSet<>();
        String[] keywords = {
            "java", "spring boot", "docker", "rest", "restful services", "rest apis",
            "mysql", "git", "kubernetes", "aws", "hibernate", "maven", "jenkins"
        };

        text = text.toLowerCase();
        for (String skill : keywords) {
            if (text.contains(skill.toLowerCase())) {
                skills.add(capitalize(skill));
            }
        }
        return skills;
    }

    // Capitalize each word
    public static String capitalize(String input) {
        String[] words = input.split(" ");
        StringBuilder sb = new StringBuilder();
        for (String w : words) {
            sb.append(Character.toUpperCase(w.charAt(0))).append(w.substring(1)).append(" ");
        }
        return sb.toString().trim();
    }

    // Compare two skill sets and return match score
    public static void compareSkills(Set<String> resumeSkills, Set<String> jdSkills) {
        Set<String> matched = new HashSet<>(resumeSkills);
        matched.retainAll(jdSkills);

        Set<String> missing = new HashSet<>(jdSkills);
        missing.removeAll(resumeSkills);

        int matchPercent = (int) ((double) matched.size() / jdSkills.size() * 100);

        System.out.println("\n=================== RESULTS ===================");
        System.out.println("✔ Resume Skills: " + resumeSkills);
        System.out.println("✔ Job Description Keywords: " + jdSkills);
        System.out.println("🎯 Match Score: " + matchPercent + "%");
        System.out.println("🟢 Matched Skills: " + matched);
        System.out.println("🔴 Missing Skills: " + missing);

        if (!missing.isEmpty()) {
            System.out.println("📌 Suggestion: Consider learning or adding: " + missing);
        } else {
            System.out.println("✅ Great! Your resume fully matches the job description.");
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("========= Resume Analyzer - Java CLI =========");
        System.out.println("Paste your resume content below (single line):");
        String resumeText = scanner.nextLine();

        System.out.println("\nPaste the job description below (single line):");
        String jdText = scanner.nextLine();

        Set<String> resumeSkills = extractSkills(resumeText);
        Set<String> jdSkills = extractSkills(jdText);

        compareSkills(resumeSkills, jdSkills);
    }
}
