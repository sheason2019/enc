/*
  Warnings:

  - Added the required column `signPubkey` to the `GroupMembers` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_GroupMembers" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "groupID" INTEGER NOT NULL,
    "signPubkey" TEXT NOT NULL,
    "snapshot" BLOB NOT NULL,
    CONSTRAINT "GroupMembers_groupID_fkey" FOREIGN KEY ("groupID") REFERENCES "Group" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_GroupMembers" ("groupID", "id", "snapshot") SELECT "groupID", "id", "snapshot" FROM "GroupMembers";
DROP TABLE "GroupMembers";
ALTER TABLE "new_GroupMembers" RENAME TO "GroupMembers";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
