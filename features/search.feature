Feature: Search GitHub
  In order to find github content
  As a visitor
  I should be able to use search page with corresponding functionality

  Background:
    Given I go to github site

  Scenario: Search form
    When I fill keyword "cucumber" in quick search field
    Then I should be on "Search" form

  Scenario Outline: Search by keyword
    When I fill keyword "cucumber" in quick search field
    And I search in "<search_type>"
    Then I should see "cucumber" in all results
    Examples:
      | search_type  | keyword  |
      | repositories | cucumber |
      #| code         | CUCUMBER |
      | issues       | CUCUmber |
      | users        | cUcUmBeR |

  Scenario Outline: No results
    When I fill keyword "v4ry_rare_w0rd" in quick search field
    And I search in "<search_type>"
    Then I should see "We couldn’t find any <search_type> matching 'v4ry_rare_w0rd'" text
    Examples:
      | search_type  |
      | repositories |
      #| code         |
      | issues       |
      | users        |

  Scenario Outline: Max number of search result items on page
    When I fill keyword "cucumber" in quick search field
    And I search in "<search_type>"
    Then I should see 10 search results on page
    Examples:
      | search_type  |
      | repositories |
      #| code         |
      | issues       |
      | users        |

  Scenario Outline: Navigation in paging
    When I fill keyword "cucumber" in quick search field
    And I search in "<search_type>"
    And current page in paging should be "1"
    And "previous" item should be disabled in paging
    When I navigate to <new> page in paging
    And current page in paging should be "<active_item>"
    And "previous" item should be enabled in paging
    When I navigate to <previous> page in paging
    And current page in paging should be "1"
    And "previous" item should be disabled in paging
    Examples:
      | search_type  | new  | active_item | previous |
      | repositories | next | 2           | previous |
      #| code         | 2    | 2           | 1        |
      | issues       | 3    | 3           | 1        |
      | users        | 4    | 4           | 1        |

  Scenario: Max number of paging items
    When I fill keyword "test" in quick search field
    Then I should see 100 paging items
    When I navigate to last page in paging
    Then current page in paging should be "100"
    And "next" item should be disabled in paging

  Scenario: Go to repository from search result
    When I fill keyword "test" in quick search field
    And I click on 1st repository link
    Then repository should correspond with search result

  # Scenario: Go to code fragment from search result
  #   When I fill keyword "test" in quick search field
  #   And I search in "code"
  #   And I click on 2nd code link
  #   Then code should correspond with search result

  Scenario: Go to issue from search result
    When I fill keyword "test" in quick search field
    And I search in "issues"
    And I click on 3rd issue link
    Then issue should correspond with search result

  Scenario: Go to user from search result
    When I fill keyword "test" in quick search field
    And I search in "users"
    And I click on last user link
    Then user should correspond with search result
