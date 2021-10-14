public class NewCaseListController {

    public List<Case> getNewCases() {
        List<Case> cases = [select Id, CaseNumber from Case where status='New'];
        return cases;
    }
}