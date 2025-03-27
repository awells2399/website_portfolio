// Function to fetch view count from the Lambda function URL
async function fetchViewCount() {
  try {
    // Fetch the configuration file
    const configResponse = await fetch("config.json");
    if (!configResponse.ok) {
      throw new Error(`HTTP error! status: ${configResponse.status}`);
    }
    const config = await configResponse.json();
    const url = config.api_url;

    // Fetch the view count from the API
    const response = await fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
    });
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const data = await response.json();
    console.log("View Count:", data.viewCount);

    // Update the view count on the webpage
    document.getElementById(
      "view-count"
    ).innerText = `Website Views: ${data.viewCount}`;
  } catch (error) {
    console.error("Error fetching view count:", error);
  }
}

// Call the function to fetch view count when the page loads
document.addEventListener("DOMContentLoaded", fetchViewCount);
