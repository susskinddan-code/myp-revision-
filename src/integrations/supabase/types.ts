export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.5"
  }
  public: {
    Tables: {
      flashcards: {
        Row: {
          back: string
          created_at: string
          front: string
          grade: number
          id: string
          subject_id: string
          topic_id: string
        }
        Insert: {
          back: string
          created_at?: string
          front: string
          grade: number
          id?: string
          subject_id: string
          topic_id: string
        }
        Update: {
          back?: string
          created_at?: string
          front?: string
          grade?: number
          id?: string
          subject_id?: string
          topic_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "flashcards_subject_id_fkey"
            columns: ["subject_id"]
            isOneToOne: false
            referencedRelation: "subjects"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "flashcards_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics"
            referencedColumns: ["id"]
          },
        ]
      }
      notes: {
        Row: {
          content: string
          id: string
          topic_id: string
        }
        Insert: {
          content: string
          id?: string
          topic_id: string
        }
        Update: {
          content?: string
          id?: string
          topic_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "notes_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: true
            referencedRelation: "topics"
            referencedColumns: ["id"]
          },
        ]
      }
      paper_questions: {
        Row: {
          answer: number
          content: string
          criterion: string | null
          id: string
          mark_scheme: string | null
          options: Json
          paper_id: string
          position: number
        }
        Insert: {
          answer: number
          content: string
          criterion?: string | null
          id?: string
          mark_scheme?: string | null
          options: Json
          paper_id: string
          position: number
        }
        Update: {
          answer?: number
          content?: string
          criterion?: string | null
          id?: string
          mark_scheme?: string | null
          options?: Json
          paper_id?: string
          position?: number
        }
        Relationships: [
          {
            foreignKeyName: "paper_questions_paper_id_fkey"
            columns: ["paper_id"]
            isOneToOne: false
            referencedRelation: "past_papers"
            referencedColumns: ["id"]
          },
        ]
      }
      past_papers: {
        Row: {
          created_at: string
          criterion: string | null
          grade: number
          id: string
          is_generated: boolean
          subject_id: string
          title: string
          year: number | null
        }
        Insert: {
          created_at?: string
          criterion?: string | null
          grade: number
          id?: string
          is_generated?: boolean
          subject_id: string
          title: string
          year?: number | null
        }
        Update: {
          created_at?: string
          criterion?: string | null
          grade?: number
          id?: string
          is_generated?: boolean
          subject_id?: string
          title?: string
          year?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "past_papers_subject_id_fkey"
            columns: ["subject_id"]
            isOneToOne: false
            referencedRelation: "subjects"
            referencedColumns: ["id"]
          },
        ]
      }
      profiles: {
        Row: {
          created_at: string
          display_name: string | null
          email: string | null
          grade: number | null
          id: string
          last_active_at: string | null
          streak_days: number
        }
        Insert: {
          created_at?: string
          display_name?: string | null
          email?: string | null
          grade?: number | null
          id: string
          last_active_at?: string | null
          streak_days?: number
        }
        Update: {
          created_at?: string
          display_name?: string | null
          email?: string | null
          grade?: number | null
          id?: string
          last_active_at?: string | null
          streak_days?: number
        }
        Relationships: []
      }
      question_attempts: {
        Row: {
          correct: boolean
          created_at: string
          id: string
          question_id: string | null
          source: string
          subject_id: string | null
          topic_id: string | null
          user_id: string
        }
        Insert: {
          correct: boolean
          created_at?: string
          id?: string
          question_id?: string | null
          source?: string
          subject_id?: string | null
          topic_id?: string | null
          user_id: string
        }
        Update: {
          correct?: boolean
          created_at?: string
          id?: string
          question_id?: string | null
          source?: string
          subject_id?: string | null
          topic_id?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "question_attempts_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "question_attempts_subject_id_fkey"
            columns: ["subject_id"]
            isOneToOne: false
            referencedRelation: "subjects"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "question_attempts_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics"
            referencedColumns: ["id"]
          },
        ]
      }
      questions: {
        Row: {
          answer: number
          content: string
          created_at: string
          difficulty: string
          explanation: string | null
          grade: number
          id: string
          mark_scheme: string | null
          options: Json
          subject_id: string
          topic_id: string
          type: string
          visual: Json | null
        }
        Insert: {
          answer: number
          content: string
          created_at?: string
          difficulty?: string
          explanation?: string | null
          grade: number
          id?: string
          mark_scheme?: string | null
          options: Json
          subject_id: string
          topic_id: string
          type?: string
          visual?: Json | null
        }
        Update: {
          answer?: number
          content?: string
          created_at?: string
          difficulty?: string
          explanation?: string | null
          grade?: number
          id?: string
          mark_scheme?: string | null
          options?: Json
          subject_id?: string
          topic_id?: string
          type?: string
          visual?: Json | null
        }
        Relationships: [
          {
            foreignKeyName: "questions_subject_id_fkey"
            columns: ["subject_id"]
            isOneToOne: false
            referencedRelation: "subjects"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "questions_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "topics"
            referencedColumns: ["id"]
          },
        ]
      }
      subjects: {
        Row: {
          description: string | null
          grades: number[]
          group_key: string
          id: string
          name: string
          position: number
          slug: string
          subject_group: string
        }
        Insert: {
          description?: string | null
          grades?: number[]
          group_key: string
          id?: string
          name: string
          position?: number
          slug: string
          subject_group: string
        }
        Update: {
          description?: string | null
          grades?: number[]
          group_key?: string
          id?: string
          name?: string
          position?: number
          slug?: string
          subject_group?: string
        }
        Relationships: []
      }
      topics: {
        Row: {
          description: string | null
          grade: number
          id: string
          name: string
          parent_topic_id: string | null
          position: number
          subject_id: string
        }
        Insert: {
          description?: string | null
          grade: number
          id?: string
          name: string
          parent_topic_id?: string | null
          position?: number
          subject_id: string
        }
        Update: {
          description?: string | null
          grade?: number
          id?: string
          name?: string
          parent_topic_id?: string | null
          position?: number
          subject_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "topics_parent_topic_id_fkey"
            columns: ["parent_topic_id"]
            isOneToOne: false
            referencedRelation: "topics"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "topics_subject_id_fkey"
            columns: ["subject_id"]
            isOneToOne: false
            referencedRelation: "subjects"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      is_mcq_options: { Args: { j: Json }; Returns: boolean }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends (DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never) = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends (PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never) = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const
