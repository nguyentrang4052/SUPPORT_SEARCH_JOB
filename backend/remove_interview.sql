-- CreateEnum
CREATE TYPE "public"."InterviewLanguage" AS ENUM ('vi', 'en');

-- CreateEnum
CREATE TYPE "public"."InterviewLevel" AS ENUM ('Fresher', 'Junior', 'Mid', 'Senior', 'Lead', 'Manager');

-- CreateEnum
CREATE TYPE "public"."InterviewStatus" AS ENUM ('in_progress', 'completed', 'cancelled');

-- CreateTable
CREATE TABLE "public"."InterviewMessage" (
    "id" SERIAL NOT NULL,
    "sessionId" INTEGER NOT NULL,
    "sender" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "language" "public"."InterviewLanguage" NOT NULL DEFAULT 'vi',
    "score" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "InterviewMessage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."InterviewReport" (
    "id" SERIAL NOT NULL,
    "sessionId" INTEGER NOT NULL,
    "overallScore" DOUBLE PRECISION,
    "technicalScore" DOUBLE PRECISION,
    "communicationScore" DOUBLE PRECISION,
    "summary" TEXT,
    "strengths" JSONB,
    "weaknesses" JSONB,
    "skillGap" JSONB,
    "recommendation" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "InterviewReport_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."InterviewSession" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "jobId" INTEGER,
    "role" TEXT NOT NULL,
    "level" "public"."InterviewLevel" NOT NULL,
    "language" "public"."InterviewLanguage" NOT NULL DEFAULT 'vi',
    "status" "public"."InterviewStatus" NOT NULL DEFAULT 'in_progress',
    "overallScore" DOUBLE PRECISION,
    "experienceYears" INTEGER,
    "duration" INTEGER,
    "questionCount" INTEGER,
    "jobRequirements" TEXT,
    "jobDescription" TEXT,
    "cvAnalysis" JSONB,
    "startedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "endedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "InterviewSession_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "InterviewReport_sessionId_key" ON "public"."InterviewReport"("sessionId" ASC);

-- CreateIndex
CREATE INDEX "InterviewSession_jobId_idx" ON "public"."InterviewSession"("jobId" ASC);

-- CreateIndex
CREATE INDEX "InterviewSession_userId_idx" ON "public"."InterviewSession"("userId" ASC);

-- AddForeignKey
ALTER TABLE "public"."InterviewMessage" ADD CONSTRAINT "InterviewMessage_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES "public"."InterviewSession"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."InterviewReport" ADD CONSTRAINT "InterviewReport_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES "public"."InterviewSession"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."InterviewSession" ADD CONSTRAINT "InterviewSession_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "public"."Job"("jobID") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."InterviewSession" ADD CONSTRAINT "InterviewSession_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("accountID") ON DELETE RESTRICT ON UPDATE CASCADE;

