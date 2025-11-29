# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/).

## [1.2.0] - 2025-08-18

🚀 **Large PDF Handling & Stability Fixes**

- Added **batch processing** for large PDFs to prevent memory issues.
- Improved **save efficiency** by skipping unmodified pages.
- Optimized **memory & I/O usage** with incremental saves.
- Kept **UI responsive** during long operations.
- Fixed PDF re-open slowdown, last-page save issues & memory leaks.

## [1.1.0] - 2025-08-06

✨ **Performance Upgrade & Enhancements**

- **Multi-threaded PDF Saving**: Heavy PDF processing tasks like drawing, annotation embedding, and image rendering are now handled in a separate isolate, significantly improving UI responsiveness during save operations.
- **Improved Drawing Accuracy**: Fixed page-index mismatch ensuring correct drawings appear on their respective pages.
- **Stability Improvements**: Reduced memory usage and improved efficiency during multi-page PDF edits.

## [1.0.0] - 2025-04-10

🎉 Initial release! & fixes

- **PDF Editing Features**: Introduced the ability to add and edit text boxes with resizing and repositioning.
- **Freehand Drawing**: Added freehand drawing with full undo/redo support.
- **Image Insertion**: Users can insert images into PDFs and manipulate their position and size.
- **Annotations**: Support for highlight and underline annotations with color customization.
- **Interactive Toolbar**: Dynamic toolbar for switching between drawing, text, annotation, and image modes.
- **Full PDF Saving**: Users can save their edits back to a new PDF file, with all modifications, including text, drawings, and annotations.
- **Multi-page Support**: Full support for multi-page PDFs with navigation and page-wise editing.

## [0.0.1] - 2025-04-10

🎉 Initial release!

- **PDF Editing Features**: Introduced the ability to add and edit text boxes with resizing and repositioning.
- **Freehand Drawing**: Added freehand drawing with full undo/redo support.
- **Image Insertion**: Users can insert images into PDFs and manipulate their position and size.
- **Annotations**: Support for highlight and underline annotations with color customization.
- **Interactive Toolbar**: Dynamic toolbar for switching between drawing, text, annotation, and image modes.
- **Full PDF Saving**: Users can save their edits back to a new PDF file, with all modifications, including text, drawings, and annotations.
- **Multi-page Support**: Full support for multi-page PDFs with navigation and page-wise editing.
