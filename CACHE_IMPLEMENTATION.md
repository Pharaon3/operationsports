# Hive Caching Implementation

This document explains how the Hive caching system has been implemented to store API responses globally.

## Overview

The caching system uses Hive (a lightweight NoSQL database) to store API responses with expiration times. When a user visits a page, the app first checks if data is already cached and not expired. If cached data exists, it's used immediately. If not, the app fetches fresh data from the API and caches it.

## Cache Expiration Times

- **Articles**: 1 hour
- **Forum data**: 30 minutes  
- **Newsletters**: 2 hours
- **Reviews**: 1 hour

## Implementation Details

### 1. CacheService (`lib/services/cache_service.dart`)

The main caching service that handles:
- Initializing Hive boxes
- Storing and retrieving cached data
- Managing expiration times
- Clearing cache for different data types

### 2. Updated Services

All API services now check cache first before making API calls:

#### ArticleService
- `fetchArticles()` - Caches main articles
- `fetchFeaturedArticles()` - Caches featured articles

#### ForumService  
- `fetchForumSections()` - Caches forum sections
- `fetchLatestActivity()` - Caches latest forum activity
- `fetchMySubscriptions()` - Caches user subscriptions

#### NewsletterService
- `fetchNewsletters()` - Caches newsletter list
- `fetchNewsletterByPage()` - Caches paginated newsletters

#### CategoryService
- `fetchCategoriesPost()` - Caches reviews (category 4849)

### 3. Updated Providers

Providers now include refresh methods that clear cache before fetching:

#### ArticleProvider
- `refreshArticles()` - Clears article cache and fetches fresh data

#### CategoryProvider  
- `refreshCategoryPost()` - Clears reviews cache and fetches fresh data

#### ForumProvider (New)
- `refreshForumSections()` - Clears forum cache and fetches fresh data
- `refreshLatestActivity()` - Clears activity cache and fetches fresh data
- `refreshMySubscriptions()` - Clears subscriptions cache and fetches fresh data

#### NewsletterProvider (New)
- `refreshNewsletters()` - Clears newsletter cache and fetches fresh data
- `refreshNewsletterByPage()` - Clears page cache and fetches fresh data

### 4. Updated Models

Added `toJson()` and `fromJson()` methods to models for serialization:

- `ForumSection` and `ForumSubItem`
- `ForumActivityItem`

## Usage

### Automatic Caching
Data is automatically cached when fetched from APIs. Users will see cached data immediately when visiting pages.

### Manual Refresh
Users can pull-to-refresh on any page to clear cache and fetch fresh data:

```dart
// In screens, use refresh methods instead of fetch methods
fetchArticles: articleProvider.refreshArticles,
```

### Cache Management
The system automatically:
- Checks cache before API calls
- Stores successful API responses
- Removes expired cache entries
- Provides methods to manually clear cache

## Benefits

1. **Faster Loading**: Cached data loads instantly
2. **Reduced API Calls**: Fewer requests to servers
3. **Offline Support**: Users can view cached data without internet
4. **Better UX**: No loading delays for previously viewed content
5. **Automatic Expiration**: Data stays fresh with configurable expiration times

## Configuration

Cache expiration times can be adjusted in `CacheService`:

```dart
static const Duration _defaultExpiration = Duration(hours: 1);
static const Duration _forumExpiration = Duration(minutes: 30);
static const Duration _newsletterExpiration = Duration(hours: 2);
```

## Dependencies Added

- `hive: ^2.2.3`
- `hive_flutter: ^1.1.0`
- `hive_generator: ^2.0.1` (dev)
- `build_runner: ^2.4.12` (dev) 