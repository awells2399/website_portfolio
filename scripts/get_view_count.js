// Function to fetch view count from the Lambda function URL
async function fetchViewCount() {
  const url =
    "https://7zen8qi7e3.execute-api.us-east-1.amazonaws.com/Production";

  try {
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
