# HYPERDRIVE (backend)

[View the React front end here](https://github.com/AngusGMorrison/hyperdrive-frontend)

The critical cyberpunk cloud storage drive you never knew you needed.

**Features:**
* Accepts file uploads for storage in a folder-and-document filesystem private to each user
* Token-based user authentication
* Stores uploaded files in a private AWS S3 bucket
* Streams files to the front end for download
* Full file CRUD
* Custom serializers ensure only essential data is returned with each response
* Variable per-user storage limits
* Containerized with Docker-Compose
