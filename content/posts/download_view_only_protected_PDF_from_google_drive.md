+++
date = 2024-07-10T11:28:20+05:45
title = "How to download view only protected PDF form Google Drive(JS Code)"
description = "Short description"
tags = ["pdf","download","view", "protected pdf", "view only pdf", "pdf viewer"]
type = "post"
showTableOfContents = true
+++

## Download view only protected PDF form Google Drive(JS Code)

###### Here you can use this script to download view only pdf file from Google Drive. This script works like a screenshot capturing all pdf pages to bulk of images with better resolution quality and combine it all into one pdf file.
Note 1: It was tested on Chrome Browser, Firefox.

Note 2: If you’re getting only part of the document visible, try zooming out your browser and then run the script.


#### Instruction:
1. Open the PDF from Google Drive
2. Click Preview
3. Scroll to the bottom of the document, so all the pages are present
4. Open Developer Tools on separate window and choose the Console tab
5. Type allow pasting
6. Then Paste the code from below and remove allow pasting from the console (and run the script)

```js

// Create a script element to load the jsPDF library
let jspdf = document.createElement('script');
// Define the function to execute once the jsPDF library is loaded
jspdf.onload = function () {
    // Create a new jsPDF instance
    let pdf = new jsPDF();
    // Get all image elements in the document
    let elements = document.getElementsByTagName("img");
    // Iterate through all image elements
    for (let i in elements) {
        let img = elements[i];
        console.log("add img ", img);
        // Check if the image source is a blob URL
        if (!/^blob:/.test(img.src)) {
            console.log("invalid src");
            continue;  // Skip the image if the source is not a blob URL
        }
        // Create a canvas element
        let can = document.createElement('canvas');
        let con = can.getContext("2d");
        // Set the canvas dimensions to match the image
        can.width = img.width;
        can.height = img.height;
        // Draw the image onto the canvas
        con.drawImage(img, 0, 0, img.width, img.height);
        // Convert the canvas content to a data URL (JPEG format)
        let imgData = can.toDataURL("image/jpeg", 1.0);
        // Add the image to the PDF
        pdf.addImage(imgData, 'JPEG', 0, 0);
        // Add a new page to the PDF for the next image
        pdf.addPage();
    }
    // Save the PDF file with the specified name
    pdf.save("Exported_File.pdf");
};
// Set the source of the script element to the jsPDF library URL
jspdf.src = 'https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js';
// Append the script element to the document body to load the jsPDF library
document.body.appendChild(jspdf);

```
<h5 style="text-align:center">OR</h5>

```js
(function () {
  console.log("Loading script ...");

  let script = document.createElement("script");
  script.onload = function () {
    const { jsPDF } = window.jspdf;

    // Generate a PDF from images with "blob:" sources.
    let pdf = null;
    let imgElements = document.getElementsByTagName("img");
    let validImgs = [];
    let initPDF = true;

    console.log("Scanning content ...");
    for (let i = 0; i < imgElements.length; i++) {
      let img = imgElements[i];

      let checkURLString = "blob:https://drive.google.com/";
      if (img.src.substring(0, checkURLString.length) !== checkURLString) {
        continue;
      }

      //   if (!/^blob:/.test(img.src)) {
      //     continue;
      //   }

      validImgs.push(img);
    }

    console.log(`${validImgs.length} content found!`);
    console.log("Generating PDF file ...");
    for (let i = 0; i < validImgs.length; i++) {
      let img = validImgs[i];
      let canvasElement = document.createElement("canvas");
      let con = canvasElement.getContext("2d");
      canvasElement.width = img.naturalWidth;
      canvasElement.height = img.naturalHeight;
      con.drawImage(img, 0, 0, img.naturalWidth, img.naturalHeight);
      let imgData = canvasElement.toDataURL();

      let orientation;
      if (img.naturalWidth > img.naturalHeight) {
        //console.log("Landscape");
        orientation = "l";
        //ratio = img.naturalWidth/img.naturalHeight
      } else {
        //console.log("Portrait");
        orientation = "p";
        //ratio = img.naturalWidth/img.naturalHeight
      }

      let pageWidth = img.naturalWidth;
      let pageHeight = img.naturalHeight;

      if (initPDF) {
        pdf = new jsPDF({
          orientation: orientation,
          unit: "px",
          format: [pageWidth, pageHeight],
        });
        initPDF = false;
      }

      if (!initPDF) {
        pdf.addImage(imgData, "PNG", 0, 0, pageWidth, pageHeight, "", "SLOW");
        if (i !== validImgs.length - 1) {
          pdf.addPage();
        }
      }

      const percentages = Math.floor(((i + 1) / validImgs.length) * 100);
      console.log(`Processing content ${percentages}%`);
    }

    // check if title contains .pdf in end of the title
    const title = document.querySelector('meta[itemprop="name"]').content;
    if (title.split(".").pop() !== "pdf") {
      title = title + ".pdf";
    }

    // Download the generated PDF.
    console.log("Downloading PDF file ...");
    pdf.save(title, { returnPromise: true }).then(() => {
      document.body.removeChild(script);
      console.log("PDF downloaded!");
    });
  };

  // Load the jsPDF library using the trusted URL.
  let scriptURL = "https://unpkg.com/jspdf@latest/dist/jspdf.umd.min.js";
  let trustedURL;
  if (window.trustedTypes && trustedTypes.createPolicy) {
    const policy = trustedTypes.createPolicy("myPolicy", {
      createScriptURL: (input) => {
        return input;
      },
    });
    trustedURL = policy.createScriptURL(scriptURL);
  } else {
    trustedURL = scriptURL;
  }

  script.src = trustedURL;
  document.body.appendChild(script);
})();
```
<h5 style="text-align:center">OR</h5>

```js
// Define the base name for the PDF document.
const pdfDocumentName = "Document";

// Initialize a variable to hold the concatenated data URLs of images.
let docDataUrls = "";

/**
 * Extracts and encodes images from the current page into a downloadable file.
 */
function generatePDFDataFile() {
  // Fetch all image elements on the page.
  const imgTags = document.getElementsByTagName("img");
  // Define the prefix for URLs to be considered (specific to Google Drive hosted images).
  const checkURLString = "blob:https://drive.google.com/";

  // Iterate over all image tags to check and process valid images.
  Array.from(imgTags).forEach(img => {
    // Check if the image's source URL matches the defined prefix.
    if (img.src.startsWith(checkURLString)) {
      // Prepare a canvas to draw the image for data URL conversion.
      const canvas = document.createElement('canvas');
      const context = canvas.getContext("2d");
      canvas.width = img.naturalWidth;
      canvas.height = img.naturalHeight;
      context.drawImage(img, 0, 0, img.naturalWidth, img.naturalHeight);

      // Convert the canvas content to a data URL.
      const imgDataURL = canvas.toDataURL();
      // Append the new data URL to the document data, separated by newlines for multiple images.
      docDataUrls += `${docDataUrls ? "\n" : ""}${imgDataURL}`;
    }
  });

  // Create a Blob from the concatenated image data URLs.
  const file = new Blob([docDataUrls], {type: 'text/plain'});
  // Generate a URL for the Blob.
  const url = URL.createObjectURL(file);
  // Create an anchor element for downloading the file.
  const anchorElement = document.createElement("a");
  anchorElement.href = url;
  anchorElement.download = `${pdfDocumentName}.PDF_DataFile`;
  // Trigger the download.
  document.body.appendChild(anchorElement);
  anchorElement.click();
}

/**
 * Identifies the tallest scrollable element and scrolls through it before generating the PDF data file.
 */
function autoScrollAndGeneratePDF() {
  // Find all elements on the page.
  const allElements = document.querySelectorAll("*");
  // Initialize variables to track the tallest scrollable element and its height.
  let chosenElement = null;
  let heightOfScrollableElement = 0;

  // Iterate over all elements to find the tallest scrollable one.
  allElements.forEach(element => {
    if (element.scrollHeight > element.clientHeight) {
      if (heightOfScrollableElement < element.scrollHeight) {
        chosenElement = element;
        heightOfScrollableElement = element.scrollHeight;
      }
    }
  });

  // Check if a scrollable element was found and needs to be scrolled.
  if (chosenElement && chosenElement.scrollHeight > chosenElement.clientHeight) {
    console.log("Auto Scroll");
    const scrollDistance = Math.round(chosenElement.clientHeight / 2);
    let remainingHeightToScroll = chosenElement.scrollHeight;
    let scrollToLocation = 0;

    /**
     * Recursively scrolls the chosen element until fully scrolled.
     * @param {number} remainingHeight - Remaining height to scroll.
     * @param {number} scrollTo - Current scroll target within the element.
     */
    function myLoop(remainingHeight, scrollTo) {
      setTimeout(() => {
        scrollTo += scrollDistance;
        chosenElement.scrollTo(0, scrollTo);
        remainingHeight -= scrollDistance;

        if (remainingHeight > 0) {
          myLoop(remainingHeight, scrollTo);
        } else {
          // After the final scroll, wait a moment before generating the PDF data file.
          setTimeout(generatePDFDataFile, 1500);
        }
      }, 400);
    }

    // Start the scrolling process.
    myLoop(remainingHeightToScroll, scrollToLocation);
  } else {
    console.log("No Scroll Needed");
    // If no scrolling is needed, wait a moment before generating the PDF data file.
    setTimeout(generatePDFDataFile, 1500);
  }
}

// Start the process.
autoScrollAndGeneratePDF();
```
<h5 style="text-align:center">OR</h5>

```js
// Function to dynamically load the jsPDF library and execute a callback function once it's loaded
function loadJsPDF(callback) {
    // Create a new script element
    let script = document.createElement("script");
    // Assign a callback function to be called once the script is fully loaded
    script.onload = callback;
    // Set the source URL of the script to the jsPDF library
    script.src = 'https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js';
    // Append the script element to the body of the document, triggering the download and execution of the jsPDF script
    document.body.appendChild(script);
}

// Main function to process the page content and generate a PDF
function processAndGeneratePDF() {
    // Initialize the document name with the desired output filename
    const pdfDocumentName = "Document.pdf";
    // This variable will hold our jsPDF instance once it's created
    let doc = null;

    // Function to add an individual image to the PDF document
    function addImageToPDF(img) {
        // Create a canvas element to draw the image on
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext("2d");
        // Set the canvas dimensions to match the image dimensions
        canvas.width = img.naturalWidth;
        canvas.height = img.naturalHeight;
        // Draw the image onto the canvas
        ctx.drawImage(img, 0, 0);

        // Convert the canvas content to a data URL that jsPDF can use
        const imgData = canvas.toDataURL();
        // Determine the orientation of the image for the PDF layout
        const orientation = img.naturalWidth > img.naturalHeight ? "l" : "p";
        // Set a scale factor to adjust the image size in the PDF
        const scaleFactor = 1.335;
        // Calculate the page dimensions based on the image size and scale factor
        const pageWidth = img.naturalWidth * scaleFactor;
        const pageHeight = img.naturalHeight * scaleFactor;

        // Check if the jsPDF instance exists, create it if not, or add a new page to it if it does
        if (!doc) {
            doc = new jsPDF({
                orientation,
                unit: "px",
                format: [pageWidth, pageHeight],
            });
        } else {
            doc.addPage([pageWidth, pageHeight], orientation);
        }

        // Add the image to the PDF document
        doc.addImage(imgData, "PNG", 0, 0, img.naturalWidth, img.naturalHeight);
    }

    // Function to identify valid images and process them for inclusion in the PDF
    function processValidImages() {
        // Retrieve all image elements from the document
        const imgTags = document.getElementsByTagName("img");
        // Define the URL pattern to filter images that should be included in the PDF
        const checkURLString = "blob:https://drive.google.com/";
        // Iterate over each image and add it to the PDF if it matches the pattern
        Array.from(imgTags).forEach(img => {
            if (img.src.startsWith(checkURLString)) {
                addImageToPDF(img);
            }
        });

        // Once all valid images are processed, save the PDF document
        if (doc) {
            doc.save(pdfDocumentName);
        }
    }

    // Function to handle scrolling for elements with significant scrollable content before generating the PDF
    function handleAutoScrollAndGeneratePDF() {
        // Identify all elements that have scrollable content
        const elementsWithScroll = Array.from(document.querySelectorAll("*")).filter(el => el.scrollHeight > el.clientHeight);
        // Select the element with the maximum scroll height to focus on
        const chosenElement = elementsWithScroll.reduce((maxEl, currentEl) => currentEl.scrollHeight > (maxEl.scrollHeight || 0) ? currentEl : maxEl, {});

        // Check if the chosen element requires scrolling
        if (chosenElement.scrollHeight > chosenElement.clientHeight) {
            console.log("Auto Scroll");
            // Initialize the remaining height to scroll through
            let remainingHeight = chosenElement.scrollHeight;
            // Calculate the distance to scroll each iteration, based on half the client height of the element
            const scrollDistance = Math.round(chosenElement.clientHeight / 2);

            // Recursive function to scroll through the element and generate the PDF afterwards
            function scrollAndGenerate() {
                if (remainingHeight > 0) {
                    // Scroll the element by the calculated distance
                    chosenElement.scrollBy(0, scrollDistance);
                    // Subtract the scrolled distance from the remaining height
                    remainingHeight -= scrollDistance;
                    // Continue scrolling after a brief delay
                    setTimeout(scrollAndGenerate, 500);
                } else {
                    // Once scrolling is complete, wait briefly before generating the PDF
                    setTimeout(processValidImages, 1500);
                }
            }

            // Start the scrolling process
            scrollAndGenerate();
        } else {
            // If no scrolling is needed, wait briefly before generating the PDF directly
            console.log("No Scroll");
            setTimeout(processValidImages, 1500);
        }
    }

    // Initiate the process of handling scrollable content and generating the PDF
    handleAutoScrollAndGeneratePDF();
}

// Start the entire process by loading the jsPDF library and then executing the main function once it's loaded
loadJsPDF(processAndGeneratePDF);
```
7. Wait script processing and downloading pdf file
8. Fast or slow pdf processing based on the pdf content itself.
9. Enjoy...


