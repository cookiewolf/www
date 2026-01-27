/*

Don't run this script directly, use `npm run build_blog`!

scripts/convert-blog-posts-to-json-payload.js <src_dir> <payload_output_file> <feed_output_file>

Looks for markdown files in src directory and bundles all that data
into one json file for deployment.

NOTE: yes i know this is a bit verbose as it does everything manually but it
also has ZERO external dependencies, which makes distribution simpler (i hope).
*/

const fs = require('node:fs/promises');
const process = require('process');

const propPattern = /^([^:]+):\s+'([^']+)'/;

function isMarkdownFile(filename) {
  return filename.endsWith(".md");
}

function readSourcePostFile(basePath, filename) {
  return new Promise((resolve, reject) => {

    fs.readFile(basePath + "/" + filename, 'utf8')
      .catch(reject)
      .then(data => {

        let props = {};
        const lines = data.split("\n");
        let pos = 0;

        if (lines[pos] === "---") {
          pos++;

          while (lines[pos] !== "---" && pos < lines.length) {
            const found = propPattern.exec(lines[pos]);
            if (found) {
              const key = found[1];
              const value = found[2];
              props[key] = value;
            }

            pos++;
          }
          if (lines[pos] === "---") {
            pos++;
          }
        }
        const payload = {
          srcFile: filename,
          props: props,
          lines: lines.slice(pos)
        };
        resolve(payload);
      });
  });
}

const datePattern = /^(\d{4})-(\d{2})-(\d{2})$/;

function normalizePostData(rawPostData) {
  return new Promise((resolve, reject) => {

    let postBySlug = {};

    const postData =
      rawPostData
        .map(rawPost => {

          const lookup = name => (rawPost.props[name] || '').trim();
          const badEnd = fieldName => reject("Bad/missing `" + fieldName + "` in `" + rawPost.srcFile + "`");

          // FIXME? reject posts with no content?

          const title = lookup('title');
          if (title.length == 0) { badEnd('title'); }

          const author = lookup('author');
          if (author.length == 0) { badEnd('author'); }

          const teaser = lookup('teaser');
          if (teaser.length == 0) { badEnd('teaser'); }

          const keywords = lookup('keywords');
          if (keywords.length == 0) { badEnd('keywords'); }

          const rawPublishDateValue = lookup('publish_date');
          // if (rawPublishDateValue.length == 0) { badEnd('publish_date'); }

          const dateMatch = datePattern.exec(rawPublishDateValue);
          let publishDate;
          if (dateMatch) {
            const year = parseInt(dateMatch[1]);
            const month = parseInt(dateMatch[2]);
            const day = parseInt(dateMatch[3]);

            publishDate = new Date(year, month, day);

          } else {
            badEnd('publish_date');
          }

          const slug =
            title
              .toLowerCase()
              .replaceAll(/\W+/g, '-')
              .replace(/-*$/, '');

          if (slug.length == 0) {
            reject("Title produces empty slug in " + rawPost.srcFile);
            return;
          }

          if (postBySlug[slug]) {
            reject("Slug is not unique in " + rawPost.srcFile);
            return;

          } else {
            postBySlug[slug] = true;
          }

          const post = {
            title: title,
            author: author,
            teaser: teaser,
            keywords: keywords,
            slug: slug,
            publish_date: publishDate.toISOString().slice(0, 10),
            content: rawPost['lines'].join("\n")
          };
          return post;
        })

    postData.sort((a, b) => {
      // by date (reversed)
      if (a.publish_date < b.publish_date) return 1;
      if (a.publish_date > b.publish_date) return -1;

      // by title
      if (a.title < b.title) return -1;
      if (a.title > b.title) return 1;

      // (should never be this)
      return 0;
    });

    resolve(postData);
  });
}

function savePostData(postData, targetFile) {
  return fs.writeFile(targetFile, JSON.stringify(postData));

  /*
  return new Promise((resolve, reject) => {
    fs
      .writeFile(targetFile, JSON.stringify(postData))
      .then(resolve)
      .catch(reject);
  });
  */
}

function saveFeed(postData, targetFile) {

  let postList =
    postData
      .map(
        post =>
          `<item>
  <title>${post.title}</title>
  <description>${post.teaser}</description>
  <link>https://cookiewolf.coop/blog/${post.slug}</link>
  <guid isPermaLink="false">${post.slug}</guid>
  <pubDate>${post.publish_date}T12:00:00.000Z</pubDate>
 </item>`)
      .join("\n");

  const builtOn = new Date().toISOString();

  const output =
    `<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0">
    <channel>
      <title>Cookiewolf blog</title>
      <description>The place for cookiewolf thoughts of all kinds.</description>
      <link>https://cookiewolf.coop</link>
      <copyright>Cookiewolf Coop</copyright>
      <lastBuildDate>${builtOn}</lastBuildDate>
      <pubDate>${builtOn}</pubDate>
      <ttl>1800</ttl>

      ${postList}
</channel>
</rss>`;

  // console.log("feed:");
  // console.log(output);

  return fs.writeFile(targetFile, output);
}

function main() {
  if (process.argv.length < 5) {
    console.error("Missing src / output / feed output arguments");
    process.exit(-1);
  }

  const srcDir = process.argv[2];
  const targetPayloadFile = process.argv[3];
  const targetFeedFile = process.argv[4];

  console.log('convert-blog-posts-to-json-payload');
  console.log("  srcDir=" + srcDir);
  console.log("  targetPayloadFile=" + targetPayloadFile)
  console.log("  targetFeedFile=" + targetFeedFile)

  fs.readdir(srcDir)
    .then(files => {
      const postFileData =
        files
          .filter(isMarkdownFile)
          .map(file => readSourcePostFile(srcDir, file));

      if (postFileData.length == 0) {
        console.error("No post files found?");
        return;
      }

      Promise
        .all(postFileData)
        .then(normalizePostData)
        .then(data =>
          Promise.all(
            [savePostData(data, targetPayloadFile), saveFeed(data, targetFeedFile)]
          ))
        .then(() => {
          console.log("all done.");
        })
        .catch(problem => {
          console.error("error:", problem);
          process.exit(-1);
        });

    });
}

main();

