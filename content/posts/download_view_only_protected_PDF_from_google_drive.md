---
date: 2024-07-10
title: How to download view only protected PDF form Google Drive (JS Code)
description: Short description
tags:
  - pdf_download, protected_pdf, view only pdf, pdf_viewer
---

## Download view only protected PDF form Google Drive(JS Code)

#### Here you can use this script to download view only pdf file from Google Drive. This script works like a screenshot capturing all pdf pages to bulk of images with better resolution quality and combine it all into one pdf file.

Note 1: It was tested on Chrome Browser, Firefox.

Note 2: If you’re getting only part of the document visible, try zooming out your browser and then run the script.

#### Instruction:

1. Open the PDF from Google Drive
2. Click Preview
3. Scroll to the bottom of the document, so all the pages are present
4. Open Developer Tools on separate window and choose the Console tab
5. Then Paste the code from below and remove allow pasting from the console (and run the script)

##### Highly Recomended to use Script 1.

###### Script 1:

```js
let jspdf = document.createElement("script");
jspdf.onload = function () {
  let pdf = new jsPDF();
  let elements = document.getElementsByTagName("img");
  for (let i in elements) {
    let img = elements[i];
    console.log("add img ", img);
    if (!/^blob:/.test(img.src)) {
      console.log("invalid src");
      continue; // Skip the image if the source is not a blob URL
    }
    let can = document.createElement("canvas");
    let con = can.getContext("2d");
    can.width = img.width;
    can.height = img.height;
    con.drawImage(img, 0, 0, img.width, img.height);
    let imgData = can.toDataURL("image/jpeg", 1.0);
    pdf.addImage(imgData, "JPEG", 0, 0);
    pdf.addPage();
  }
  // Save the PDF file with the specified name
  pdf.save("Exported_File.pdf");
};
jspdf.src = "https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js";
document.body.appendChild(jspdf);
```

###### Script 2:

```js
(function () {
  console.log("Loading script ...");

  let script = document.createElement("script");
  script.onload = function () {
    const { jsPDF } = window.jspdf;
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
        orientation = "l";
      } else {
        orientation = "p";
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
    const title = document.querySelector('meta[itemprop="name"]').content;
    if (title.split(".").pop() !== "pdf") {
      title = title + ".pdf";
    }
    console.log("Downloading PDF file ...");
    pdf.save(title, { returnPromise: true }).then(() => {
      document.body.removeChild(script);
      console.log("PDF downloaded!");
    });
  };
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

###### Script 3:

```js
const pdfDocumentName = "Document";
let docDataUrls = "";
function generatePDFDataFile() {
  const imgTags = document.getElementsByTagName("img");
  const checkURLString = "blob:https://drive.google.com/";
  Array.from(imgTags).forEach((img) => {
    if (img.src.startsWith(checkURLString)) {
      const canvas = document.createElement("canvas");
      const context = canvas.getContext("2d");
      canvas.width = img.naturalWidth;
      canvas.height = img.naturalHeight;
      context.drawImage(img, 0, 0, img.naturalWidth, img.naturalHeight);
      const imgDataURL = canvas.toDataURL();
      docDataUrls += `${docDataUrls ? "\n" : ""}${imgDataURL}`;
    }
  });
  const file = new Blob([docDataUrls], { type: "text/plain" });
  const url = URL.createObjectURL(file);
  const anchorElement = document.createElement("a");
  anchorElement.href = url;
  anchorElement.download = `${pdfDocumentName}.PDF_DataFile`;
  document.body.appendChild(anchorElement);
  anchorElement.click();
}
function autoScrollAndGeneratePDF() {
  const allElements = document.querySelectorAll("*");
  let chosenElement = null;
  let heightOfScrollableElement = 0;
  allElements.forEach((element) => {
    if (element.scrollHeight > element.clientHeight) {
      if (heightOfScrollableElement < element.scrollHeight) {
        chosenElement = element;
        heightOfScrollableElement = element.scrollHeight;
      }
    }
  });
  if (
    chosenElement &&
    chosenElement.scrollHeight > chosenElement.clientHeight
  ) {
    console.log("Auto Scroll");
    const scrollDistance = Math.round(chosenElement.clientHeight / 2);
    let remainingHeightToScroll = chosenElement.scrollHeight;
    let scrollToLocation = 0;
    function myLoop(remainingHeight, scrollTo) {
      setTimeout(() => {
        scrollTo += scrollDistance;
        chosenElement.scrollTo(0, scrollTo);
        remainingHeight -= scrollDistance;
        if (remainingHeight > 0) {
          myLoop(remainingHeight, scrollTo);
        } else {
          setTimeout(generatePDFDataFile, 1500);
        }
      }, 400);
    }
    myLoop(remainingHeightToScroll, scrollToLocation);
  } else {
    console.log("No Scroll Needed");
    setTimeout(generatePDFDataFile, 1500);
  }
}
autoScrollAndGeneratePDF();
```

###### Script 4:

```js
function loadJsPDF(callback) {
  let script = document.createElement("script");
  script.onload = callback;
  script.src =
    "https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js";
  document.body.appendChild(script);
}
function processAndGeneratePDF() {
  const pdfDocumentName = "Document.pdf";
  let doc = null;
  function addImageToPDF(img) {
    const canvas = document.createElement("canvas");
    const ctx = canvas.getContext("2d");
    canvas.width = img.naturalWidth;
    canvas.height = img.naturalHeight;
    ctx.drawImage(img, 0, 0);
    const imgData = canvas.toDataURL();
    const orientation = img.naturalWidth > img.naturalHeight ? "l" : "p";
    const scaleFactor = 1.335;
    const pageWidth = img.naturalWidth * scaleFactor;
    const pageHeight = img.naturalHeight * scaleFactor;
    if (!doc) {
      doc = new jsPDF({
        orientation,
        unit: "px",
        format: [pageWidth, pageHeight],
      });
    } else {
      doc.addPage([pageWidth, pageHeight], orientation);
    }
    doc.addImage(imgData, "PNG", 0, 0, img.naturalWidth, img.naturalHeight);
  }
  function processValidImages() {
    const imgTags = document.getElementsByTagName("img");
    const checkURLString = "blob:https://drive.google.com/";
    Array.from(imgTags).forEach((img) => {
      if (img.src.startsWith(checkURLString)) {
        addImageToPDF(img);
      }
    });
    if (doc) {
      doc.save(pdfDocumentName);
    }
  }
  function handleAutoScrollAndGeneratePDF() {
    const elementsWithScroll = Array.from(
      document.querySelectorAll("*"),
    ).filter((el) => el.scrollHeight > el.clientHeight);
    const chosenElement = elementsWithScroll.reduce(
      (maxEl, currentEl) =>
        currentEl.scrollHeight > (maxEl.scrollHeight || 0) ? currentEl : maxEl,
      {},
    );
    if (chosenElement.scrollHeight > chosenElement.clientHeight) {
      console.log("Auto Scroll");
      let remainingHeight = chosenElement.scrollHeight;
      const scrollDistance = Math.round(chosenElement.clientHeight / 2);
      function scrollAndGenerate() {
        if (remainingHeight > 0) {
          chosenElement.scrollBy(0, scrollDistance);
          remainingHeight -= scrollDistance;
          setTimeout(scrollAndGenerate, 500);
        } else {
          setTimeout(processValidImages, 1500);
        }
      }
      scrollAndGenerate();
    } else {
      console.log("No Scroll");
      setTimeout(processValidImages, 1500);
    }
  }
  handleAutoScrollAndGeneratePDF();
}
loadJsPDF(processAndGeneratePDF);
```

6. Wait script processing and downloading pdf file
7. Fast or slow pdf processing based on the pdf content itself.
8. Enjoy...
