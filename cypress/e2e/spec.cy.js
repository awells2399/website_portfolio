describe("Test if Resume website is live", () => {
  it("Visits Aaron Wells Resume Website", () => {
    cy.visit("https://resume.alwells.live");
  });
});

describe("Test if clicking the arrow navigates to the About section", () => {
  it("Clicks the arrow and checks if it navigates to the About section", () => {
    cy.visit("https://resume.alwells.live");

    // Assuming the arrow has a class of 'scroll-down' or similar
    cy.get(".scroll-down a").click();

    // Check if the URL includes '#about'
    cy.url().should("include", "#about");

    // Optionally, check if the About section is visible
    cy.get("#about").should("be.visible");
  });
});

describe("Test if website viewer count is displayed", () => {
  it("Checks if the website viewer count is displayed and contains a number", () => {
    cy.visit("https://resume.alwells.live");

    // Check if the view count element is present and contains the expected text
    cy.get("#view-count")
      .should("be.visible")
      .and("contain.text", "Website Views:");

    // Check if the view count element contains a number
    cy.get("#view-count")
      .invoke("text")
      .then((text) => {
        const viewCount = text.match(/\d+/);
        expect(viewCount).to.not.be.null;
      });
  });
});

describe("Test if Download Resume link works", () => {
  it("Checks if the Download Resume link initiates a download", () => {
    cy.visit("https://resume.alwells.live");

    // Assuming the download link has a class of 'download-resume' or similar
    cy.get(".download-resume a")
      .should("have.attr", "href")
      .and("include", "AaronWellsResume_v2_website.pdf");

    // Optionally, you can click the link to ensure it works
    cy.get(".download-resume a").click();
  });
});

describe("Test if GitHub and LinkedIn icons navigate to their respective sites", () => {
  it("Checks if the GitHub icon navigates to the GitHub profile", () => {
    cy.visit("https://resume.alwells.live");

    // Assuming the GitHub icon has a class of 'fab fa-github' or similar
    cy.get(".fab.fa-github")
      .parent()
      .should("have.attr", "href", "https://github.com/awells2399");
  });

  it("Checks if the LinkedIn icon navigates to the LinkedIn profile", () => {
    cy.visit("https://resume.alwells.live");

    // Assuming the LinkedIn icon has a class of 'fab fa-linkedin' or similar
    cy.get(".fab.fa-linkedin")
      .parent()
      .should(
        "have.attr",
        "href",
        "https://www.linkedin.com/in/aaron-wells-21192485/"
      );
  });
});

describe("Checks if contact section can take input", () => {
  it("Gets, types and asserts", () => {
    cy.visit("https://resume.alwells.live");

    // Get an input, type into it
    cy.get("input").type("Randomemail@example.com");

    //  Verify that the value has been updated
    cy.get("input").should("have.value", "Randomemail@example.com");

    // Get a textarea, type into it
    cy.get("textarea").type("This is a test message");

    //  Verify that the value has been updated
    cy.get("textarea").should("have.value", "This is a test message");
  });
});
