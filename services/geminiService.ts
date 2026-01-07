import { GoogleGenAI } from "@google/genai";

// Initialize the Gemini client
const ai = new GoogleGenAI({ apiKey: process.env.API_KEY });

/**
 * Generates a personalized encouragement message for English learners.
 */
export const generateWelcomeMessage = async (interest: string): Promise<string> => {
  try {
    const model = 'gemini-3-flash-preview';
    const prompt = `
      당신은 친절하고 열정적인 영어 선생님 "English Boost"입니다.
      사용자가 영어 학습 앱의 사전 예약을 신청했습니다.
      사용자의 현재 영어 학습 목표나 어려움은 다음과 같습니다: "${interest}".
      
      이 학생에게 동기를 부여해줄 수 있는 따뜻하고 힘이 되는 한 문장을 한국어로 작성해주세요. (최대 20단어).
      이 앱으로 그 목표를 달성할 수 있다는 뉘앙스를 풍겨주세요.
      따옴표 없이 문장만 출력해주세요. 이모지를 하나 포함해주세요.
    `;

    const response = await ai.models.generateContent({
      model: model,
      contents: prompt,
      config: {
        maxOutputTokens: 100,
        temperature: 0.8,
      }
    });

    return response.text || "영어 정복의 첫 걸음을 응원합니다! 🚀";
  } catch (error) {
    console.error("Gemini API Error:", error);
    return "함께라면 영어, 어렵지 않아요! 파이팅 💪";
  }
};